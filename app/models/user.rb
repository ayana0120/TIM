class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         # , :omniauthable, :trackable

  validates :name, presence: true

  has_many :items
  has_many :genres

  protected

  def self.form_omniauth(auth)
  	where(uid: auth.uid, provider: auth.provider).firs_or_create do |user|
  	  	user.name = auth.info.name
  	  	user.id = auth.uid
        user.email = auth.info.email
  	  	user.passsword = Devise.friendy_token[0,20]
  	end
  end
end
