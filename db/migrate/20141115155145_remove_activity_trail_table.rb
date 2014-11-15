class RemoveActivityTrailTable < ActiveRecord::Migration
  def change
  	drop_table :activity_trails
  end
end
