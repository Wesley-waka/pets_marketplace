module Api
  module V1
    class ProfilesController < ApiController
      before_action :set_profile, only: %i[update_profile show_profile]

      def show_profile; end

      def update_profile
        if @profile.update(profile_params)
          render 'update_profile'
        else
          render json: { error: @profile.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def profile_params
        params.require(:profile).permit(:first_name, :last_name, :bio, :account_type, :language, :location, :facebook_url, :twitter_url, :linkedin_url, :whatsapp_url, :profile_image, :phone_number)
      end

      def set_profile
        @profile = current_user.profile

        return render json: { error: 'Profile not found' }, status: :not_found unless @profile.present?
      end
    end
  end
end
