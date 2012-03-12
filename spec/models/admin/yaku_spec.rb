require 'spec_helper'

describe Admin::Yaku do
  fixtures :admin_yakus
  set_fixture_class :admin_yakus => Admin::Yaku

  before(:each) do
    @yaku = admin_yakus(:pinfu)
  end

  it 'should respond to name, han_num, naki_han_num' do
    @yaku.name.should == "pinfu"
    @yaku.han_num.should == 1
    @yaku.naki_han_num.should == 0
  end
end
