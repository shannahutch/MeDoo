class Week < ActiveRecord::Base
  validates :weekly_goal_name, presence: true
  belongs_to :goals

end
