class CreateMonths < ActiveRecord::Migration
  def change
    create_table :months do |t|
      t.string :month_name
      t.string :month_goal_1
      t.string :month_goal_2
      t.string :month_goal_3
      t.integer :goal_id

      t.timestamps
    end
  end
end
