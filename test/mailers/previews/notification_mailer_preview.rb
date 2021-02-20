# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/notification_mailer/warning
  def warning
    NotificationMailer.warning
  end

  # Preview this email at http://localhost:3000/rails/mailers/notification_mailer/expired
  def expired
    NotificationMailer.expired
  end
end
