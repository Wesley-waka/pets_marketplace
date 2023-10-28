class UserMailer < Devise::Mailer
  default from: "easymobile1441@gmail.com"

  def reset_password_instructions(record, token, opts = {})
    super
  end
end
