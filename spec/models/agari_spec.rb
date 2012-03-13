require 'spec_helper'

describe 'Default value of', Agari do
  before(:each) do
    @agari = Agari.new(:img => 'hoge')
  end

  describe '.bakaze' do
    it 'should be equal to :ton in default' do
      @agari.bakaze.should == 'ton'
    end
  end

  describe '.jikaze' do
    it 'should be equal to :ton in default' do
      @agari.jikaze.should == 'ton'
    end
  end

  describe '.honba_num' do
    it 'should be equal to 0 in default' do
      @agari.honba_num.should == 0
    end
  end

  describe '.is_tsumo' do
    it 'should be equal to false in default' do
      @agari.is_tsumo.should be_false
    end
  end

  describe '.dora_num' do
    it 'should be equal to 0 in default' do
      @agari.dora_num.should == 0
    end
  end

  describe '.reach_num' do
    it 'should be equal to 0 in default' do
      @agari.dora_num.should == 0
    end
  end

  describe '.is_ippatsu' do
    it 'should be equal to false in default' do
      @agari.is_ippatsu.should be_false
    end
  end

  describe '.is_haitei' do
    it 'should be equal to false in default' do
      @agari.is_haitei.should be_false
    end
  end

  describe '.is_rinshan' do
    it 'should be equal to false in default' do
      @agari.is_rinshan.should be_false
    end
  end

  describe '.is_chankan' do
    it 'should be equal to false in default' do
      @agari.is_chankan.should be_false
    end
  end

  describe '.is_tenho' do
    it 'should be equal to false in default' do
      @agari.is_tenho.should be_false
    end
  end

  describe '.is_chiho' do
    it 'should be equal to false in default' do
      @agari.is_chiho.should be_false
    end
  end

  describe '.is_parent' do
    it 'should be equal to false in default' do
      @agari.is_parent.should be_false
    end
  end
end

describe Agari do
  subject { Agari.new(:img => 'hoge') }

  it { should accept_values_for(:img, 'valid1234') }
  it { should not_accept_values_for(:img, nil) }

  it { should accept_values_for(:bakaze, 'ton', 'nan', 'sha', 'pei') }
  it { should not_accept_values_for(:bakaze, 'invalid', 1) }

  it { should accept_values_for(:jikaze, 'ton', 'nan', 'sha', 'pei') }
  it { should not_accept_values_for(:jikaze, 'invalid', 1) }

  it { should accept_values_for(:honba_num, 0, 1, 2, 3, 4, 5, 6, 7, 8) }
  it { should not_accept_values_for(:honba_num, 'invalid', -1, 1.5) }

  it { should accept_values_for(:is_tsumo, true, false) }
  it { should not_accept_values_for(:is_tsumo, 'invalid', 1, 1.5) }

  it { should accept_values_for(:dora_num, 0, 1, 2, 3, 4, 5, 6, 7, 8) }
  it { should not_accept_values_for(:dora_num, 'invalid', -1, 1.5) }

  it { should accept_values_for(:reach_num, 0, 1, 2, 3, 4, 5, 6, 7, 8) }
  it { should not_accept_values_for(:reach_num, 'invalid', -1, 1.5) }

  it { should accept_values_for(:is_ippatsu, true, false) }
  it { should not_accept_values_for(:is_ippatsu, 'invalid', 1, 1.5) }

  it { should accept_values_for(:is_haitei, true, false) }
  it { should not_accept_values_for(:is_haitei, 'invalid', 1, 1.5) }

  it { should accept_values_for(:is_rinshan, true, false) }
  it { should not_accept_values_for(:is_rinshan, 'invalid', 1, 1.5) }

  it { should accept_values_for(:is_chankan, true, false) }
  it { should not_accept_values_for(:is_chankan, 'invalid', 1, 1.5) }

  it { should accept_values_for(:is_tenho, true, false) }
  it { should not_accept_values_for(:is_tenho, 'invalid', 1, 1.5) }

  it { should accept_values_for(:is_tenho, true, false) }
  it { should not_accept_values_for(:is_tenho, 'invalid', 1, 1.5) }

  it { should accept_values_for(:is_chiho, true, false) }
  it { should not_accept_values_for(:is_chiho, 'invalid', 1, 1.5) }

  it { should accept_values_for(:is_parent, true, false) }
  it { should not_accept_values_for(:is_parent, 'invalid', 1, 1.5) }
end

describe Agari do

  before(:all) do
    @img_dir = File.join(File.dirname(__FILE__), '../test_imgs')
  end

  describe ".to_json" do
    it 'should be serialize to json format' do
      agari = Agari.new(:img => 'hoge')
      json = ActiveSupport::JSON.decode(agari.to_json)['agari']
      json.should == agari.serializable_hash
    end
  end

  describe '.analyze' do
    it 'should be equal to tehai' do
      f = open("#{@img_dir}/1.jpg", 'rb')
      img = Base64.encode64(f.read)
      agari = Agari.new(:img => img, :is_tsumo => true)
      f.close

      agari.analyze
      agari.tehai_list.should == 'j7tj7tj7tp1tp1tp2tp2tp3tp3tp4tp4tp4tp5tp6t'
      agari.total_fu_num.should == 30
      agari.total_han_num.should == 6
      agari.child_point.should == 3000
      agari.parent_point.should == 6000
      agari.ron_point.should == 0
      agari.total_point.should == 12000
      agari.mangan_scale.should == 1.5
      agari.is_furo.should be_false
      agari.yaku_list.should have(4).items
      agari.yaku_list.any?{|yaku| yaku.name=='honitsu'}.should be_true
      agari.yaku_list.any?{|yaku| yaku.name=='iipeikou'}.should be_true
      agari.yaku_list.any?{|yaku| yaku.name=='chun'}.should be_true
      agari.yaku_list.any?{|yaku| yaku.name=='tsumo'}.should be_true
    end

    context 'when analyzes image which causes mentsu error' do
      it 'should have errors' do
        f = open("#{@img_dir}/mentsu_error.jpg", 'rb')
        img = Base64.encode64(f.read)
        f.close

        agari = Agari.new(:img => img)
        agari.analyze

        agari.errors.should have_at_least(1).items
      end
    end
  end
end
