class NotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.warning.subject
  #
  def warning(user, item)
    @user = user
    @item = item
    @url = "http://ec2-13-230-253-117.ap-northeast-1.compute.amazonaws.com/users/#{@user.id}"
    mail to: @user.email,
         subject: "期限の3日前をお知らせします"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.expired.subject
  #
  def expired(user, item)
    @user = user
    @item = item
    @url = "http://ec2-13-230-253-117.ap-northeast-1.compute.amazonaws.com/users/#{@user.id}"
    mail to: @user.email,
         subject: "期限をお知らせします"
  end
end
