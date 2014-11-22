class AddingStateToUseractivityTable < ActiveRecord::Migration
  def change
  	add_column :user_activities, :state, :string, :default => 'stopped'
  end
end
