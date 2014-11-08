class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.integer :creator_id
      t.boolean :is_public
      t.boolean :is_live

      t.timestamps
    end
  end
end
