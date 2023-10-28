class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :profile_image

  enum account_type: %i[seller buyer]

  def profile_image_blob_url
     Rails.application.config.action_mailer.default_url_options[:port] = 3001
    if self.profile_image.present?
      Rails.application.routes.url_helpers.rails_blob_url(
        profile_image&.blob,
        Rails.application.config.action_mailer.default_url_options.merge(only_path: false, host: '161.35.126.102')
      )
    end
  end
end
