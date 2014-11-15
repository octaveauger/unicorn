class UserActivity < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity
  validates :user_id, presence: true
  validates :activity_id, presence: true

  def self.generate_initial_activities(user)
  	@activities = Activity.available_activities(user)
    UserActivity.transaction do
  		@activities.each do |activity|
        UserActivity.create(activity: activity, user: user, is_displayed: true)
  		end
  	end
  end
end
