require 'spec_helper'

describe Agari do
  before(:each) do
    @agari = Agari.new
  end

  describe '.bakaze' do
    it 'should be equal to :ton in default' do
      @agari.bakaze.should == :ton
    end
  end

  describe '.jikaze' do
    it 'should be equal to :ton in default' do
      @agari.jikaze.should == :ton
    end
  end

  describe '.honba_num' do
    it 'should be equal to 0 in default' do
      @agari.honba_num.should == 0
    end
  end

  describe '.is_tsumo' do
    it 'should be equal to false in default' do
      @agari.is_tsumo.should == false
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
      @agari.is_ippatsu.should == false
    end
  end

  describe '.is_haitei' do
    it 'should be equal to false in default' do
      @agari.is_haitei.should == false
    end
  end

  describe '.is_rinshan' do
    it 'should be equal to false in default' do
      @agari.is_rinshan.should == false
    end
  end

  describe '.is_chankan' do
    it 'should be equal to false in default' do
      @agari.is_chankan.should == false
    end
  end

  describe '.is_tenho' do
    it 'should be equal to false in default' do
      @agari.is_tenho.should == false
    end
  end

  describe '.is_chiho' do
    it 'should be equal to false in default' do
      @agari.is_chiho.should == false
    end
  end

  describe '.is_parent' do
    it 'should be equal to false in default' do
      @agari.is_parent.should == false
    end
  end
end
