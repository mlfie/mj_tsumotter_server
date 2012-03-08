class AgarisController < ApplicationController
  respond_to :json
  # POST /agaris.json
  def create
    agari = Agari.new(params[:agari])
    if agari.valid?
      # DO analysis
    end

    respond_with(agari)
  end
end
