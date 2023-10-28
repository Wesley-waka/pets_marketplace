# frozen_string_literal: true

class Users::SessionsController < Api::V1::ApiController
  skip_before_action :authenticate_request
  include RackSessionFix

  def create
    current_user = User.find_by_email(params[:user][:email])
    if current_user.present?
      user_authentication(current_user)
    else
      render json: { error: 'Some went wrong, please check your email!.' }, status: :not_found
    end
  end

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: "Logged in sucessfully."}
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: "logged out successfully"
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
