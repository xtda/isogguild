module Api
  module V1
    module Wow
    # Retreive update to date realm list from armory
      class RealmsController < ApiController
        include Wowarmory

        skip_before_action :authenticate_user, only: [:index, raise: false]

        def index
          realms = realm_list
          render json: realms
        end
      end
    end
  end
end
