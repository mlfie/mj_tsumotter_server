class AgarisController < ApplicationController
  respond_to :json
  # POST /agaris.json
  def create
    agari = Agari.new(params[:agari])
    agari.valid?
    respond_with(agari)
  end
end
