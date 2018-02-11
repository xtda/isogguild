class RemorseappController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    @applications = Playerapplication.all
  end

  def show
    return redirect_to root_url unless params.key?(:viewkey)
    @application = Playerapplication.where(id: params[:id], viewkey: params[:viewkey]).first
    redirect_to root_url unless @application
  end
end
