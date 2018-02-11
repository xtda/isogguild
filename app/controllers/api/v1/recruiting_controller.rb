module Api
  module V1
    class RecruitingController < ApiController
      skip_before_action :authenticate_user

      def index
        @recruiting = Setting.find_by(name: 'recruiting').settings#['class']
        render json: @recruiting
      end
    end
  end
end
