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
  describe ".to_json" do
    it 'should be serialize to json format' do
      agari = Agari.new(:img => 'hoge')
      json = ActiveSupport::JSON.decode(agari.to_json)['agari']
      json.should == agari.serializable_hash
    end
  end
end
