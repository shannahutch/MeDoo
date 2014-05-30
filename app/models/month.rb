class Month < ActiveRecord::Base
  validates :month_goal_name, presence: true
  belongs_to :goal
  has_many :weeks

end
