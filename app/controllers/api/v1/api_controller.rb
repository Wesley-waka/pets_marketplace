module Api
  module V1
    class ApiController < ActionController::Base
      before_action :authenticate_request
      
      def user_authentication(user)
        if user.is_active?
          if user.authenticate(params[:user][:email], params[:user][:password])
            expiration_time = 1.hour.from_now.to_i # Set the expiration time, e.g., 1 hour from now

            jwt_token = JWT.encode({user_id: user.id, exp: expiration_time}, ENV['SECRET_KEY_BASE'], 'HS256')

            response.headers['Authorization'] = "Bearer #{jwt_token}"
            render json: {
              status: { code: 200, message: "Logged in successfully.", user_token: jwt_token }
            }
          else
            render json: { error: 'Invalid email or password' }, status: :unauthorized
            return
          end
        else
          render json: { error: 'Please confirm your account first!' }, status: :unauthorized
        end
      end


      private
    
      def authenticate_request
        token = request.headers['Authorization']&.split(' ')&.last
        return render json: { error: 'Missing token, Please Provide the user token!' }, status: :unauthorized unless token

        user = user_token_encode_and_decode(token)
        current_user = sign_in(user, store: false) if user.present?
      end

      def user_token_encode_and_decode(token)
        begin
          decoded_token = JWT.decode(token, ENV['SECRET_KEY_BASE'], true, algorithm: 'HS256')
        rescue JWT::DecodeError => e
          return render json: { error: e.message }, status: :unauthorized
        end
        user_id = decoded_token[0]['user_id']
        user = User.find_by(id: user_id)
        return render json: { error: 'Invalid token user not found' }, status: :unauthorized unless user

        return user
      end
    end
  end
end
