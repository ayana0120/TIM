ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    address: 'smtp.gmail.com',
    domain: 'gmail.com',
    port: 587,
    user_name: ENV["Google_Email"],
    password: ENV["Google_Password"],
    authentication: 'plain',
    enable_starttls_auto: true
  }