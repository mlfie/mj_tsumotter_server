require 'spec_helper'

describe "admin/yakus/index" do
  before(:each) do
    assign(:admin_yakus, [
      stub_model(Admin::Yaku, :name => 'pinfu', :han_num => 1, :naki_han_num => 0),
      stub_model(Admin::Yaku, :name => 'tanyao', :han_num => 1, :naki_han_num => 1)
    ])
  end

  it "renders a list of admin/yakus" do
    render
    rendered.should contain('pinfu')
    rendered.should contain('1')
    rendered.should contain('0')
  end
end
