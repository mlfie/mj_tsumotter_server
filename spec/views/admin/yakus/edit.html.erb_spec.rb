require 'spec_helper'

describe "admin/yakus/edit" do
  before(:each) do
    @admin_yaku = assign(:admin_yaku, stub_model(Admin::Yaku))
  end

  it "renders the edit admin_yaku form" do
    render

    rendered.should have_selector("form", :action => admin_yaku_path(@admin_yaku), :method => "post") do |form|
      form.should have_selector('label', :content => 'name'.humanize)
      form.should have_selector('label', :content => 'han_num'.humanize)
      form.should have_selector('label', :content => 'naki_han_num'.humanize)
      form.should have_selector('input', :type => 'text')
      form.should have_selector('input', :type => 'submit')
    end
  end
end
