module Api
  module V1
    class SocialLoginController < ApiController
      protect_from_forgery except: %i[social_login]
      skip_before_action :authenticate_request
      def social_login
        return render json: { error: 'Invalid provider type.' }, status: :bad_request unless %w[google facebook].include? params['provider']

        response = SocialLoginService.new(params['provider'], params['user_info_token']).social_logins

        user_with_social_login(response)
      end

      def user_with_social_login(response)
        if response.keys.include?('error_description') || response.keys.include?('error')
          render json: { error: response.values[0], status: 400 }, status: :bad_request
        elsif response.keys.include?(:error_messages)
          render json: { error: response.values[0], user_token: response.values[1] }, status: :bad_request
        else
          token_expiry_time = 24.hours.from_now.to_i
          user = response[:social_user]
          jwt_token = JWT.encode({user_id: user.id, exp: token_expiry_time}, ENV['SECRET_KEY_BASE'], 'HS256')
          render json: { status: { code: 200, message: "Logged in successfully.", user_token: jwt_token } }
        end
      end
    end
  end
end
