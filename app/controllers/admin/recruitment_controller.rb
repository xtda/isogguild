module Admin
  class RecruitmentController < AdminController
     #skip_before_action :require_login
     #skip_before_action :verify_authenticity_token, only: [:update]

    def update
      @recruiting = Setting.find_by(name: 'recruiting')
      @recruiting.settings = params[:settings]
      if @recruiting.save
        flash[:success] = 'Recruitment widget updated'
        return render json: { status: 'success' }, status: 200
      end
      render json: { status: 'shit broke' }, status: 422
    end

    def index
      @recruiting = Setting.find_by(name: 'recruiting').settings
    end
  end
end
