require 'spec_helper'

describe AgarisController do
  before(:each) do
    @agari = Agari.new(:img => 'hoge')
  end

  describe 'POST /agaris.json' do
    it 'should return json response' do
      post :create, :agari => {:img => 'hoge'}, :format => 'json'
      response = ActiveSupport::JSON.decode(@response.body)['agari']
      response.should == @agari.serializable_hash
    end
  end
end
