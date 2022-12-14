class Deadline < ApplicationRecord
  belongs_to :mode_of_transport
  validates_with ValidateMinimumDistance
  validates_with ValidateMaximumDistance
  validates :minimum_distance, :maximum_distance, presence: true
  validates :estimated_time, comparison: { greater_than: 0 }

  def ==(other)
    minimum_distance.to_s == (other[:minimum_distance]).to_s &&
      maximum_distance.to_s == (other[:maximum_distance]).to_s &&
      estimated_time.to_s == (other[:estimated_time]).to_s
  end
end
