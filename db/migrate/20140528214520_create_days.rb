class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.string :day_task_name
      t.integer :year
      t.integer :month
      t.integer :week_num
      t.integer :day
      t.references :goal, index: true

      t.timestamps
    end
  end
end
