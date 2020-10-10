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

  def self.find_for_ouath(auth)
  	user = User.where(uid: auth.uid, provider: auth.provider).first

  	unless user
  	  user = User.create(
  	  	name: auth.info.name,
  	  	uid: auth.uid,
  	  	provider: auth.provider,
  	  	email: User.dummy_email(auth),
  	  	passsword: Devise.friendy_token[0,20]
  		)
  	end
  	user
  end

  	def self.dummy_email(auth)
  	  "#{auth.uid}-#{auth.provider}@example.com"
  	end
end
