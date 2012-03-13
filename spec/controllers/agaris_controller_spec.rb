require 'spec_helper'

describe AgarisController do
  fixtures :admin_yakus
  set_fixture_class :admin_yakus => Admin::Yaku

  before(:all) do
    @img_dir = File.join(File.dirname(__FILE__), '../test_imgs')
  end

  before(:each) do
    @agari = Agari.new(:img => 'hoge')
  end

  describe 'POST /agaris.json' do
    it 'should return json response' do
      f = open("#{@img_dir}/1.jpg", 'rb')
      img = Base64.encode64(f.read)
      f.close

      post :create, :agari => {:img => img, :is_tsumo => true},:format => 'json'
      response = ActiveSupport::JSON.decode(@response.body)
      response.should have_key('agari')
      
      agari = response['agari']
      agari['bakaze'].should == 'ton'
      agari['jikaze'].should == 'ton'
      agari['honba_num'].should == 0
      agari['dora_num'].should == 0
      agari['reach_num'].should == 0
      agari['is_tsumo'].should be_true
      agari['is_haitei'].should be_false
      agari['is_rinshan'].should be_false
      agari['is_chankan'].should be_false
      agari['is_tenho'].should be_false
      agari['is_chiho'].should be_false
      agari['is_parent'].should be_false
      agari['total_fu_num'].should == 30
      agari['total_han_num'].should == 6
      agari['total_point'].should == 12000
      agari['child_point'].should == 3000
      agari['parent_point'].should == 6000
      agari['ron_point'].should == 0
      agari['mangan_scale'].should == 1.5
      agari['is_furo'].should be_false
      agari['tehai_list'].should == 'j7tj7tj7tp1tp1tp2tp2tp3tp3tp4tp4tp4tp5tp6t'
      agari['yaku_list'].should have(4).items
      agari['yaku_list'].any?{|yaku| yaku['name']=='honitsu'}.should be_true
      agari['yaku_list'].any?{|yaku| yaku['name']=='iipeikou'}.should be_true
      agari['yaku_list'].any?{|yaku| yaku['name']=='chun'}.should be_true
      agari['yaku_list'].any?{|yaku| yaku['name']=='tsumo'}.should be_true
      p agari
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
