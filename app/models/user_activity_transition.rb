class UserActivityTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition
  
  belongs_to :user_activity, inverse_of: :user_activity_transitions
end
