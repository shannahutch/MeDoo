class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.string :weekly_goal_name
      t.integer :goal_id
      t.integer :week_num
      t.integer :year
      t.integer :month

      t.timestamps
    end
  end
end
