require "spec_helper"

describe Admin::YakusController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/yakus").should route_to("admin/yakus#index")
    end

    it "routes to #new" do
      get("/admin/yakus/new").should route_to("admin/yakus#new")
    end

    it "routes to #show" do
      get("/admin/yakus/1").should route_to("admin/yakus#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/yakus/1/edit").should route_to("admin/yakus#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/yakus").should route_to("admin/yakus#create")
    end

    it "routes to #update" do
      put("/admin/yakus/1").should route_to("admin/yakus#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/yakus/1").should route_to("admin/yakus#destroy", :id => "1")
    end

  end
end
