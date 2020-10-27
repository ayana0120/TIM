class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[yahoojp twitter google_oauth2]

  has_many :items, dependent: :delete_all
  has_many :genres, dependent: :delete_all
  has_many :notifications

  after_create :send_email_on_create
  after_update :send_email_on_update, if: :saved_change_to_email?

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def self.form_omniauth(auth)
  	where(uid: auth.uid, provider: auth.provider).first_or_create do |user|
      user.email = auth.info.email
	  	user.password = Devise.friendly_token[0,20]
  	end
  end

  private

  def send_email_on_create
    RegistrationMailer.send_when_new(self).deliver_now
  end

  def send_email_on_update
    RegistrationMailer.send_when_update(self).deliver_now
  end

end
