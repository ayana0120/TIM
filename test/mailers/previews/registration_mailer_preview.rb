# Preview all emails at http://localhost:3000/rails/mailers/registration_mailer
class RegistrationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/registration_mailer/send_when_new
  def send_when_new
  	user = User.new(name: "山田太郎", email: "a@a")
    RegistrationMailer.send_when_new(user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/registration_mailer/send_when_update
  def send_when_update
  	user = User.new(name: "山田太郎", email: "a@a")
    RegistrationMailer.send_when_update(user)
  end

end
