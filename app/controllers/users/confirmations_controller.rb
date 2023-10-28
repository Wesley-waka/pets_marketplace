# frozen_string_literal: true
class Users::ConfirmationsController < Devise::ConfirmationsController
  # Your custom methods or overrides go here
  def new
    super
  end

  # This action is responsible for confirming the user account based on the confirmation token.
  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.find_by_confirmation_token(params[:user][:confirmation_token])

    if resource.nil?
      return render json: { error: 'Invalid confirmation token.' }, status: :unauthorized
    elsif resource.confirmed?
      return render json: { error: 'User is already confirmed.' }, status: :unauthorized
    elsif resource.confirmation_sent_at < Time.now - 2.days
      return render json: { error: 'Confirmation token has expired. Please request a new one.' }, status: :unauthorized
    else
      resource.update!(is_active: true)
      return render json: { message: 'Your account has been successfully confirmed.' }, status: :ok
    end
  end

end