class UserActivityStateMachine
	include Statesman::Machine

	#saving the current state in the UserActivity model
	after_transition do |model, transition|
		model.state = transition.to_state
		model.save!
	end

	#Define all possible states
	state :stopped, initial: :true
	state :started

	#Define transition rules
	transition from: :stopped, to: :started
	transition from: :started, to: :stopped

	#If a user activity starts, stops all other that were already started for that user
	before_transition(from: :stopped, to: :started) do |user_activity, transition|
		user_activity.user.user_activities.in_state(:started).readonly(false).each do |act|
			act.state_machine.transition_to!(:stopped)
		end
	end

	event :toggle do
		transition from: :started, to: :stopped
		transition from: :stopped, to: :started
	end
end