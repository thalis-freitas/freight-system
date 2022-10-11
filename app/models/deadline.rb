class Deadline < ApplicationRecord
  belongs_to :mode_of_transport
  validates_with ValidateMinimumDistance
  validates_with ValidateMaximumDistance
  validates :minimum_distance, :maximum_distance, presence: true
  validates :estimated_time, comparison: { greater_than: 0 }

  def ==(other)
    "#{self.minimum_distance}"  == "#{other[:minimum_distance]}" && 
    "#{self.maximum_distance}"  == "#{other[:maximum_distance]}" && 
    "#{self.estimated_time}"  == "#{other[:estimated_time]}"
  end
end
