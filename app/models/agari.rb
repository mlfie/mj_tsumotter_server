class Agari
  extend ActiveModel::Naming
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :img, :bakaze, :jikaze, :honba_num, :is_tsumo,
    :dora_num, :reach_num, :is_ippatsu, :is_rinshan, :is_chankan,
    :is_haitei, :is_tenho, :is_chiho, :is_parent

  validates_presence_of :img

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

  private
  def init_attributes(attributes)
    @img = attributes[:img]
    @bakaze = attributes[:bakaze] || :ton
    @jikaze = attributes[:jikaze] || :ton
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
