# _*_ encoding: utf-8 _*_

require 'spec_helper'

describe "Admin::Yakus" do
  fixtures :admin_yakus
  set_fixture_class :admin_yakus => Admin::Yaku

  describe "GET /admin_yakus" do
    it "should be able to add new yaku" do
      visit admin_yakus_path
      click_link 'New Yaku'
      fill_in 'Name', :with => 'tanyao'
      fill_in 'Han num', :with => '1'
      fill_in 'Naki han num', :with => '0'
      click_button 'Create Yaku'
    end

    it "should be able to update yaku" do
      visit admin_yakus_path
      click_link 'Edit'
      fill_in 'Name', :with => 'pinfu_new'
      fill_in 'Han num', :with => '2'
      fill_in 'Naki han num', :with => '1'
      click_button 'Update Yaku'
    end

    it "should be able to show yaku" do
      visit admin_yakus_path
      click_link 'Show'
      response.should contain('Name')
    end

    it "should be able to delete yaku" do
      visit admin_yakus_path
      response.should contain('pinfu')
      click_link 'Destroy'
    end
  end
end
