class Month < ActiveRecord::Base

  belongs_to :goal
  has_many :weeks

end
