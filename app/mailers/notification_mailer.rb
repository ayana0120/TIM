class NotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.warning.subject
  #
  def warning(user)
    @user = user
    @url = "http://localhost:3000/users/#{@user.id}"
    mail to: @user.email,
         subject: "期限の3日前をお知らせします"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.expired.subject
  #
  def expired(user)
    @user = user
    @url = "http://localhost:3000/users/#{@user.id}"
    mail to: @user.email,
         subject: "期限をお知らせします"
  end
end
