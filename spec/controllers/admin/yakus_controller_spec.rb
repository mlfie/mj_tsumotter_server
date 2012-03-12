require 'spec_helper'

describe Admin::YakusController do

  # This should return the minimal set of attributes required to create a valid
  # Admin::Yaku. As you add validations to Admin::Yaku, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {:name => 'tanyao', :han_num => 1, :naki_han_num => 1}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Admin::YakusController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all admin_yakus as @admin_yakus" do
      yaku = Admin::Yaku.find(:all)
      get :index, {}, valid_session
      assigns(:admin_yakus).should eq(yaku)
    end
  end

  describe "GET show" do
    it "assigns the requested admin_yaku as @admin_yaku" do
      yaku = Admin::Yaku.create! valid_attributes
      get :show, {:id => yaku.to_param}, valid_session
      assigns(:admin_yaku).should eq(yaku)
    end
  end

  describe "GET new" do
    it "assigns a new admin_yaku as @admin_yaku" do
      get :new, {}, valid_session
      assigns(:admin_yaku).should be_a_new(Admin::Yaku)
    end
  end

  describe "GET edit" do
    it "assigns the requested admin_yaku as @admin_yaku" do
      yaku = Admin::Yaku.create! valid_attributes
      get :edit, {:id => yaku.to_param}, valid_session
      assigns(:admin_yaku).should eq(yaku)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Admin::Yaku" do
        expect {
          post :create, {:admin_yaku => valid_attributes}, valid_session
        }.to change(Admin::Yaku, :count).by(1)
      end

      it "assigns a newly created admin_yaku as @admin_yaku" do
        post :create, {:admin_yaku => valid_attributes}, valid_session
        assigns(:admin_yaku).should be_a(Admin::Yaku)
        assigns(:admin_yaku).should be_persisted
      end

      it "redirects to the created admin_yaku" do
        post :create, {:admin_yaku => valid_attributes}, valid_session
        response.should redirect_to(Admin::Yaku.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved admin_yaku as @admin_yaku" do
        # Trigger the behavior that occurs when invalid params are submitted
        Admin::Yaku.any_instance.stub(:save).and_return(false)
        post :create, {:admin_yaku => {}}, valid_session
        assigns(:admin_yaku).should be_a_new(Admin::Yaku)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Admin::Yaku.any_instance.stub(:save).and_return(false)
        post :create, {:admin_yaku => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested admin_yaku" do
        yaku = Admin::Yaku.create! valid_attributes
        # Assuming there are no other admin_yakus in the database, this
        # specifies that the Admin::Yaku created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Admin::Yaku.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => yaku.to_param, :admin_yaku => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested admin_yaku as @admin_yaku" do
        yaku = Admin::Yaku.create! valid_attributes
        put :update, {:id => yaku.to_param, :admin_yaku => valid_attributes}, valid_session
        assigns(:admin_yaku).should eq(yaku)
      end

      it "redirects to the admin_yaku" do
        yaku = Admin::Yaku.create! valid_attributes
        put :update, {:id => yaku.to_param, :admin_yaku => valid_attributes}, valid_session
        response.should redirect_to(yaku)
      end
    end

    describe "with invalid params" do
      it "assigns the admin_yaku as @admin_yaku" do
        yaku = Admin::Yaku.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Admin::Yaku.any_instance.stub(:save).and_return(false)
        put :update, {:id => yaku.to_param, :admin_yaku => {}}, valid_session
        assigns(:admin_yaku).should eq(yaku)
      end

      it "re-renders the 'edit' template" do
        yaku = Admin::Yaku.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Admin::Yaku.any_instance.stub(:save).and_return(false)
        put :update, {:id => yaku.to_param, :admin_yaku => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested admin_yaku" do
      yaku = Admin::Yaku.create! valid_attributes
      expect {
        delete :destroy, {:id => yaku.to_param}, valid_session
      }.to change(Admin::Yaku, :count).by(-1)
    end

    it "redirects to the admin_yakus list" do
      yaku = Admin::Yaku.create! valid_attributes
      delete :destroy, {:id => yaku.to_param}, valid_session
      response.should redirect_to(admin_yakus_url)
    end
  end

end
