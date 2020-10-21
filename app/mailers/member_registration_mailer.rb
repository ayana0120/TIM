class MemberRegistrationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.member_registration_mailer.send_when_new.subject
  #
  def send_when_new(user)
    @user = user
  	mail to: @user.email,
  		 subject: "会員登録が完了しました"
  	@url = "http://localhost:3000/users/#{@user.id}"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.member_registration_mailer.send_when_update.subject
  #
  def send_when_update(user)
    @user = user
  	mail to: @user.email,
  	     subject: "会員情報が更新されました"
  	@url = "http://localhost:3000/users/#{@user.id}"
  end
end
