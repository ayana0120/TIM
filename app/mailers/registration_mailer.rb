class RegistrationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.registration_mailer.send_when_new.subject
  #
  def send_when_new(user)
    @user = user
    @url = "http://localhost:3000/users/#{@user.id}"
    mail to: @user.email,
         subject: "会員登録が完了しました"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.registration_mailer.send_when_update.subject
  #
  def send_when_update(user)
    @user = user
    @url = "http://localhost:3000/users/#{@user.id}"
    mail to: @user.email,
         subject: "会員情報を変更しました"
  end
end
