require 'spec_helper'

describe "admin/yakus/new" do
  before(:each) do
    assign(:admin_yaku, stub_model(Admin::Yaku).as_new_record)
  end

  it "renders new admin_yaku form" do
    render

    rendered.should have_selector("form", :action => admin_yakus_path, :method => "post") do |form|
      form.should have_selector('label', :content => 'name'.humanize)
      form.should have_selector('label', :content => 'han_num'.humanize)
      form.should have_selector('label', :content => 'naki_han_num'.humanize)
      form.should have_selector('input', :type => 'text') 
      form.should have_selector('input', :type => 'submit') 
    end
  end
end
