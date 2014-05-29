class Goal < ActiveRecord::Base

  has_many :months
  has_many :weeks
  has_many :days

end
