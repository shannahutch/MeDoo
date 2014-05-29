class RemoveMonthFromWeeks < ActiveRecord::Migration
  def change
    remove_column :weeks, :month, :integer
  end
end
