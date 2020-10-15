class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[yahoojp twitter google_oauth2]

  has_many :items
  has_many :genres

  def self.form_omniauth(auth)
  	where(uid: auth.uid, provider: auth.provider).first_or_create do |user|
      user.email = auth.info.email
	  	user.password = Devise.friendly_token[0,20]
  	end
  end
end
