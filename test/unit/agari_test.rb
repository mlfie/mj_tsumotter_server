require 'test_helper'

class AgariLintTest < ActiveModel::TestCase
  include ActiveModel::Lint::Tests

  def setup
    @model = Agari.new
  end
end
