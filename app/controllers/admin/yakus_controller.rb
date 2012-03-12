class Admin::YakusController < ApplicationController
  # GET /admin/yakus
  # GET /admin/yakus.json
  def index
    @admin_yakus = Admin::Yaku.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_yakus }
    end
  end

  # GET /admin/yakus/1
  # GET /admin/yakus/1.json
  def show
    @admin_yaku = Admin::Yaku.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_yaku }
    end
  end

  # GET /admin/yakus/new
  # GET /admin/yakus/new.json
  def new
    @admin_yaku = Admin::Yaku.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_yaku }
    end
  end

  # GET /admin/yakus/1/edit
  def edit
    @admin_yaku = Admin::Yaku.find(params[:id])
  end

  # POST /admin/yakus
  # POST /admin/yakus.json
  def create
    @admin_yaku = Admin::Yaku.new(params[:admin_yaku])

    respond_to do |format|
      if @admin_yaku.save
        format.html { redirect_to @admin_yaku, notice: 'Yaku was successfully created.' }
        format.json { render json: @admin_yaku, status: :created, location: @admin_yaku }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_yaku.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/yakus/1
  # PUT /admin/yakus/1.json
  def update
    @admin_yaku = Admin::Yaku.find(params[:id])

    respond_to do |format|
      if @admin_yaku.update_attributes(params[:admin_yaku])
        format.html { redirect_to @admin_yaku, notice: 'Yaku was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_yaku.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/yakus/1
  # DELETE /admin/yakus/1.json
  def destroy
    @admin_yaku = Admin::Yaku.find(params[:id])
    @admin_yaku.destroy

    respond_to do |format|
      format.html { redirect_to admin_yakus_url }
      format.json { head :no_content }
    end
  end
end
