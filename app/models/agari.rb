class Agari
  attr_accessor :bakaze, :jikaze, :honba_num, :is_tsumo,
    :dora_num, :reach_num, :is_ippatsu, :is_rinshan, :is_chankan,
    :is_tenho, :is_chiho, :is_parent

  # Required dependency for ActiveModel::Errors
  extend ActiveModel::Naming
  attr_accessor :name
  attr_reader :errors

  include ActiveModel::Validations

  # Required for ActiveModel
  def to_model
    self
  end

  # Required for ActiveModel
  def persisted?
    false
  end

  # Required for ActiveModel
  # return nil if persisted? is false
  def to_key
    nil
  end

  # Required for ActiveModel
  def to_partial_path
    'agaris'
  end

  # Required for ActiveModel
  # return nil if persisted? is false
  def to_param
    nil
  end

  def initialize

    #Required for ActiveModel
    @errors = ActiveModel::Errors.new(self)
  end

end
