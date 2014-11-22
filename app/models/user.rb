class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :user_activities, dependent: :destroy
  has_many :activities, through: :user_activities, foreign_key: "creator_id", dependent: :destroy
  
  after_create :generate_default_activities

  def generate_default_activities
  	UserActivity.generate_initial_activities(self)
  end
end
