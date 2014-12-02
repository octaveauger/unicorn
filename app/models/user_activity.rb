class UserActivity < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordQueries

  belongs_to :user
  belongs_to :activity
  has_many :user_activity_transitions
  validates :user_id, presence: true
  validates :activity_id, presence: true
  scope :visible,  -> { where(is_displayed: true) }

  def self.available
    visible.joins(:activity).merge(Activity.visible_to_all)
  end

  def self.generate_initial_activities(user)
  	@activities = Activity.available_activities(user)
    UserActivity.transaction do
  		@activities.each do |activity|
        UserActivity.create(activity: activity, user: user, is_displayed: true)
  		end
  	end
  end

  # Initialize the state machine
  def state_machine
    @state_machine ||= UserActivityStateMachine.new(self, transition_class: UserActivityTransition)
  end

  # Return the current started activity for that user, or nil
  def self.current_started_transition(user)
    started_activity = user.user_activities.in_state(:started)
    started_activity.empty? ? nil : self.find(started_activity).state_machine.last_transition
  end

  private

    def self.transition_class
      UserActivityTransition
    end

    def self.initial_state
      UserActivityStateMachine.initial_state
    end
end
