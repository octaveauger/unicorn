class CreateUserActivities < ActiveRecord::Migration
  def change
    create_table :user_activities do |t|
      t.references :user, index: true
      t.references :activity, index: true
      t.boolean :is_displayed

      t.timestamps
    end
  end
end
