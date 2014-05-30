class Day < ActiveRecord::Base
  belongs_to :goal
  validates :day_task_name, presence: true
end
