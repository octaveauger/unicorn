class CreateActivityTrails < ActiveRecord::Migration
  def change
    create_table :activity_trails do |t|
      t.integer :user_id
      t.string :action
      t.datetime :time
      t.integer :activity_id

      t.timestamps
    end
  end
end
