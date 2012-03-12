require 'spec_helper'

describe "admin/yakus/show" do
  before(:each) do
    @admin_yaku = assign(:admin_yaku, stub_model(Admin::Yaku, :name => 'pinfu', :han_num => 1, :naki_han_num => 0))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain('pinfu')
    rendered.should contain('1')
    rendered.should contain('0')
  end
end
