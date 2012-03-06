class AgarisController < ApplicationController
  respond_to :json
  # POST /agaris.json
  def create
    agari = Agari.new(params[:agari])
    respond_with(agari)
  end
end
