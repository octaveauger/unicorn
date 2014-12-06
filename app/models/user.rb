class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:google_oauth2]
  
  has_many :user_activities, dependent: :destroy
  has_many :activities, through: :user_activities, foreign_key: "creator_id", dependent: :destroy
  
  after_create :generate_default_activities
  after_create :send_welcome_email

  def generate_default_activities
  	UserActivity.generate_initial_activities(self)
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first
    unless user
      user = User.create(email: data["email"],
        password: Devise.friendly_token[0,20],
        provider: access_token.provider,
        uid: access_token.uid,
      )
    end
    user
  end
end
