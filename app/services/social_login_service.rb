# frozen_string_literal: true

class SocialLoginService
  require 'net/http'
  require 'net/https'
  PASSWORD_DIGEST = SecureRandom.hex(10)

  def initialize(provider, token)
    @token = token
    @provider = provider.downcase
  end

  def social_logins
    case @provider
    when 'google'
      google_signup(@token)
    when 'facebook'
      facebook_signup(@token)
    end
  end

  def google_signup(token)
    uri = URI("https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{token}")
    response = Net::HTTP.get_response(uri)
    return JSON.parse(response.body) if response.code != '200'
    
    json_response = JSON.parse(response.body)
    user = create_user(json_response)
    response_handling(user)
  end

  def facebook_signup(token)
    uri = URI("https://graph.facebook.com/v13.0/me?fields=name,email&access_token=#{token}")
    response = Net::HTTP.get_response(uri)
    return JSON.parse(response.body) if response.code != '200'

    json_response = JSON.parse(response.body)
    user = create_user(json_response)
    response_handling(user)
  end

  private

  def create_user(response)
    user = User.find_by_email(response['email'])
    if user.present?
      return user
    else
      user = User.create!(
        email: response['email'],
        password: PASSWORD_DIGEST, password_confirmation: PASSWORD_DIGEST,
        is_active: true
      )
      return user
    end
  end

  def response_handling(user)
    if user.errors.any?
      error_message = user.errors.full_messages
      response = {
        error_messages: error_message,
        token: 'Token Not Created'
      }
    else
      token = JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base, 'HS256') if user.id.present?
      response = {
        social_user: user,
        social_user_token: token
      }
    end
    response
  end
end
