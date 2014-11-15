class RemoveTimeFromActivityTrail < ActiveRecord::Migration
  def change
  	remove_column :activity_trails, :time
  end
end
