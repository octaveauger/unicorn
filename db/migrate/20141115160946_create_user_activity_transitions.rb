class CreateUserActivityTransitions < ActiveRecord::Migration
  def change
    create_table :user_activity_transitions do |t|
      t.string :to_state
      t.text :metadata, default: "{}"
      t.integer :sort_key
      t.integer :user_activity_id
      t.timestamps
    end

    add_index :user_activity_transitions, :user_activity_id
    add_index :user_activity_transitions, [:sort_key, :user_activity_id], unique: true, :name => 'index_user_activity_transitions_on_two_things'
  end
end
