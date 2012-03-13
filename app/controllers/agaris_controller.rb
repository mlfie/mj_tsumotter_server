class AgarisController < ApplicationController
  respond_to :json
  # POST /agaris.json
  def create
    agari = Agari.new(params[:agari])
    if agari.valid?
      if agari.analyze
        respond_with(agari)
      else
        respond_to do |format|
          format.json {render :text => agari.errors.to_json,
                       :status => :internal_server_error}
        end
      end
    else
      respond_with(agari)
    end
  end
end
