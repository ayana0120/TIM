# Preview all emails at http://localhost:3000/rails/mailers/member_registration_mailer
class MemberRegistrationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/member_registration_mailer/send_when_new
  def send_when_new
    MemberRegistrationMailer.send_when_new
  end

  # Preview this email at http://localhost:3000/rails/mailers/member_registration_mailer/send_when_update
  def send_when_update
    MemberRegistrationMailer.send_when_update
  end

end
