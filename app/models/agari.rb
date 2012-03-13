require 'mjcv'
require 'mjparse'

class Agari
  extend ActiveModel::Naming
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::Serializers::JSON
  include Mjparse

  attr_accessor :img, :bakaze, :jikaze, :honba_num, :is_tsumo,
    :dora_num, :reach_num, :is_ippatsu, :is_rinshan, :is_chankan,
    :is_haitei, :is_tenho, :is_chiho, :is_parent,
    :tehai_list, :total_fu_num, :total_han_num, :child_point, :parent_point,
    :ron_point, :total_point, :mangan_scale, :is_furo, :yaku_list

  validates_presence_of :img
  validates :honba_num, :numericality => { :only_integer => true,
                                           :greater_than_or_equal_to => 0}
  validates :dora_num, :numericality => { :only_integer => true,
                                           :greater_than_or_equal_to => 0}
  validates :reach_num, :numericality => { :only_integer => true,
                                           :greater_than_or_equal_to => 0}
  validate :bakaze, :bakaze_should_be_ton_nan_sha_pei
  validate :jikaze, :jikaze_should_be_ton_nan_sha_pei

  validates_inclusion_of :is_tsumo, :in => [true, false]
  validates_inclusion_of :is_ippatsu, :in => [true, false]
  validates_inclusion_of :is_rinshan, :in => [true, false]
  validates_inclusion_of :is_chankan, :in => [true, false]
  validates_inclusion_of :is_haitei, :in => [true, false]
  validates_inclusion_of :is_tenho, :in => [true, false]
  validates_inclusion_of :is_chiho, :in => [true, false]
  validates_inclusion_of :is_parent, :in => [true, false]

  def bakaze_should_be_ton_nan_sha_pei
    unless ['ton', 'nan', 'sha', 'pei'].any? {|kaze| kaze == bakaze}
      errors.add(:bakaze, "should be 'ton' or 'nan' or 'sha' or 'pei'")
    end
  end

  def jikaze_should_be_ton_nan_sha_pei
    unless ['ton', 'nan', 'sha', 'pei'].any? {|kaze| kaze == jikaze}
      errors.add(:jikaze, "should be 'ton' or 'nan' or 'sha' or 'pei'")
    end
  end

  def initialize(attributes = {})
    #Required for ActiveModel
    @errors = ActiveModel::Errors.new(self)
    init_attributes(attributes)
  end

  # Required dependency for ActiveModel::Errors
  attr_accessor :name
  attr_reader :errors

  # Agari are never persisted in DB
  def persisted?
    false
  end

  # for json serialization
  def attributes
    {'bakaze' => bakaze,
     'jikaze' => jikaze,
     'honba_num' => honba_num,
     'is_tsumo' => is_tsumo,
     'dora_num' => dora_num,
     'reach_num' => reach_num,
     'is_ippatsu' => is_ippatsu,
     'is_rinshan' => is_rinshan,
     'is_chankan' => is_chankan,
     'is_haitei' => is_haitei,
     'is_tenho' => is_tenho,
     'is_chiho' => is_chiho,
     'is_parent' => is_parent,
     'total_fu_num' => total_fu_num,
     'total_han_num' => total_han_num,
     'total_point' => total_point,
     'child_point' => child_point,
     'parent_point' => parent_point,
     'ron_point' => ron_point,
     'mangan_scale' => mangan_scale,
     'is_furo' => is_furo,
     'tehai_list' => tehai_list,
     'yaku_list' => yaku_list
    }
  end

  def analyze
    analyze_image
    analyze_teyaku
  end

  def analyze_image
    temp = Tempfile.new('mjt', File.join(Rails.root, 'imgtmp'))
    begin
      temp.binmode
      temp.write(Base64.decode64(self.img))

      analyzer = MjCV::CV::TemplateMatchingAnalyzer.new
      self.tehai_list = analyzer.analyze(temp.path)
    ensure
      temp.close
      temp.unlink
    end
  end

  def analyze_teyaku
    teyaku_decider = TeyakuDecider.new
    teyaku_decider.get_agari_teyaku(self.tehai_list, self.kyoku, self.yaku_specimen)

    if teyaku_decider.result_code == TeyakuDecider::RESULT_SUCCESS
      set_teyaku_result(teyaku_decider)
    else
      #error
    end
  end

  def set_teyaku_result(teyaku_decider)
    self.total_fu_num = teyaku_decider.teyaku.fu_num
    self.total_han_num = teyaku_decider.teyaku.han_num
    self.yaku_list = teyaku_decider.teyaku.yaku_list.map do |yaku_spec|
      Admin::Yaku.find_by_name(yaku_spec.name)
    end
    self.mangan_scale = teyaku_decider.teyaku.mangan_scale
    self.total_point = teyaku_decider.teyaku.total_point
    self.parent_point = teyaku_decider.teyaku.parent_point
    self.child_point = teyaku_decider.teyaku.child_point
    self.ron_point = teyaku_decider.teyaku.ron_point
    self.is_furo = teyaku_decider.teyaku.furo
  end

  def yaku_specimen
    unless @yaku_specimen
      @yaku_specimen = Hash.new
      Admin::Yaku.all.each do |yaku|
        @yaku_specimen[yaku.name] =
          YakuSpecimen.new(yaku.name, nil, yaku.han_num, yaku.naki_han_num)
      end
    end
    @yaku_specimen
  end

  def kyoku
    kyoku = Kyoku.new
    kyoku.is_tsumo = self.is_tsumo
    kyoku.is_haitei = self.is_haitei
    kyoku.dora_num = self.dora_num
    kyoku.bakaze = self.bakaze
    kyoku.jikaze = self.jikaze
    kyoku.honba_num = self.honba_num
    kyoku.is_rinshan = self.is_rinshan
    kyoku.is_chankan = self.is_chankan
    kyoku.reach_num = self.reach_num
    kyoku.is_ippatsu = self.is_ippatsu
    kyoku.is_tenho = self.is_tenho
    kyoku.is_chiho = self.is_chiho
    kyoku.is_parent = self.is_parent
    return kyoku
  end

  private
  def init_attributes(attributes)
    @img = attributes[:img]
    @bakaze = attributes[:bakaze] || 'ton'
    @jikaze = attributes[:jikaze] || 'ton'
    @honba_num = attributes[:honba_num] || 0
    @is_tsumo = attributes[:is_tsumo] || false
    @dora_num = attributes[:dora_num] || 0
    @reach_num = attributes[:reach_num] || 0
    @is_ippatsu = attributes[:is_ippatsu] || false
    @is_rinshan = attributes[:is_rinshan] || false
    @is_chankan = attributes[:is_chankan] || false
    @is_haitei = attributes[:is_haitei] || false
    @is_tenho = attributes[:is_tenho] || false
    @is_chiho = attributes[:is_chiho] || false
    @is_parent = attributes[:is_parent] || false
  end

end
