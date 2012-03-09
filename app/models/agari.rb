require 'mjcv'

class Agari
  extend ActiveModel::Naming
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::Serializers::JSON

  attr_accessor :img, :bakaze, :jikaze, :honba_num, :is_tsumo,
    :dora_num, :reach_num, :is_ippatsu, :is_rinshan, :is_chankan,
    :is_haitei, :is_tenho, :is_chiho, :is_parent,
    :tehai_list

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
     'is_parent' => is_parent
    }
  end

  def analyze
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
