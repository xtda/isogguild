class PlayerappController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :require_login, only: [:index]

  def index
    @applications = Playerapp.all.select(:id, :viewkey, :player_name,
                                         :player_class, :player_spec,
                                         :player_links, :player_bnettag)
  end

  def show
    return redirect_to root_url unless params.key?(:viewkey)
    @application = Playerapp.where(id: params[:id], viewkey: params[:viewkey]).includes(:playerappanswers).first
    redirect_to root_url unless @application
  end

  def new
    @player_name = params[:name] unless !params.key?(:name)
    @questions = Appquestion.where(enabled: true).order('position asc')
    @application = Playerapp.new
  end

  def create
    @application = Playerapp.new(application_params)
    if verify_recaptcha(model: @application, message: 'ReCAPTCHA verification failed') && @application.save
      return render json: { status: 'success' }, status: 201
    else
      return render json: { status: 'ReCAPTCHA failed' }, status: 422
    end
  end

  private

  def application_params
    params.require(:playerapp).permit(:player_name, :player_realm,
                                      :player_bnettag,
                                      :player_class, :player_spec, :player_links,
                                      playerappanswers_attributes: [:name, :question, :answer, :position])
  end
end
