module V1
  # ApiController
  class ApiController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods
    before_action :authenticate_user

    def current_user
      @current_user ||= authenticate_token
    end

    protected

    def authenticate_user
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, _options|
        token = Base64.decode64(token).split('|')
        user = User.find_by(id: token[0], token: token[1])
        if user
          ActiveSupport::SecurityUtils.secure_compare(
            ::Digest::SHA256.hexdigest(token[1]),
            ::Digest::SHA256.hexdigest(user.token)
          )
          return user
        end
      end
      false
    end

    def render_unauthorized(realm = 'Application')
      # headers['WWW-Authenticate'] = %(Token realm="#{realm.gsub(/"/, "")}")
      headers['WWW-Authenticate'] = %(Token realm="#{realm.delete('/')}")
      unauthorized!
    end

    def error!(message, status)
      render json: { error: message }, status: status
    end

    def unauthorized!
      error!('Unauthorized', 401)
    end

    def forbidden!
      error!('forbidden', 403)
    end
  end
end
