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

  describe 'POST /agaris.json' do
    context 'with no "img" value' do
      it 'should return "unprocessable entity(422)"' do
        post :create, :agari => {:invalid => 'request'}, :format => 'json'
        response.response_code.should == 422
      end
    end

    context 'with negative "dora_num"' do
      it 'should return "unprocessable entity(422)"' do
        post :create, :agari => {:img => 'hoge', :dora_num => -1}, :format => 'json'
        response.response_code.should == 422
      end
    end
  end
end
