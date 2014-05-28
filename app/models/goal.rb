class Goal < ActiveRecord::Base

  has_many :months
  has_many :weeks

end
