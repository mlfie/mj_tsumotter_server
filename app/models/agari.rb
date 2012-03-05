class Agari
  attr_accessor :bakaze, :jikaze, :honba_num, :is_tsumo,
    :dora_num, :reach_num, :is_ippatsu, :is_rinshan, :is_chankan,
    :is_tenho, :is_chiho, :is_parent

  # Required dependency for ActiveModel::Errors
  extend ActiveModel::Naming
  attr_accessor :name
  attr_reader :errors

  include ActiveModel::Validations
  include ActiveModel::Conversion

  # Agari are never persisted in DB
  def persisted?
    false
  end

  def initialize

    #Required for ActiveModel
    @errors = ActiveModel::Errors.new(self)
  end

end
