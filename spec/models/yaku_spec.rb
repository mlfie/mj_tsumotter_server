require 'spec_helper'

describe Yaku do
  fixtures :yakus

  before(:each) do
    @yaku = yakus(:pinfu)
  end

  it 'should respond to name, han_num, naki_han_num' do
    @yaku.name.should == "pinfu"
    @yaku.han_num.should == 1
    @yaku.naki_han_num.should == 0
  end
end
