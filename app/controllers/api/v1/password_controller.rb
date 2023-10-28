module Api
  module V1
    class PasswordController < ApiController
      skip_before_action :authenticate_request

      def forgot
        return render json: { error: 'Email not present' }, status:  :unprocessable_entity if params[:email].blank?
        
        user = User.find_by(email: params[:email])
        
        if user.present?
          user.generate_password_token!(user)
          token = user.reset_password_token
          UserMailer.reset_password_instructions(user, token).deliver_now
          render json: {
            message: 'Reset password link has been sent to your email.',
            reset_password_token: token, email: user.email
          }, status: :ok
        else
          render json: { error: ['Email address not found. Please check and try again.'] }, status: :not_found
        end
      end

      def reset
        return render json: { error: 'Token not present' }, status: :not_found if params[:token].blank?
        
        token = params[:token].to_s

        # return render json: { error: 'Email not present' }, status: :not_found if params[:user][:email].blank?
        user = User.find_by(reset_password_token: token)
        user_reset_password(user)
      end

      def user_reset_password(user)
        if user.present? && user.password_token_valid?
          if user.reset_password!(params[:user][:password], user)
            user_authentication(user)
          else
            render json: { error: user.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: ['Link not valid or expired. Try generating a new link.'] }, status: :not_found
        end
      end
    end
  end
end
