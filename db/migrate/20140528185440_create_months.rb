class CreateMonths < ActiveRecord::Migration
  def change
    create_table :months do |t|
      t.string :month_goal_name
      t.integer :goal_id
      t.integer :month_num
      t.integer :year

      t.timestamps
    end
  end
end
