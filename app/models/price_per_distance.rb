class PricePerDistance < ApplicationRecord
  belongs_to :mode_of_transport
  validates_with ValidateMinimumDistance
  validates_with ValidateMaximumDistance
  validates :minimum_distance, :maximum_distance, presence: true
  validates :rate, comparison: { greater_than_or_equal_to: 0 }

  def ==(other)
    minimum_distance.to_s == (other[:minimum_distance]).to_s &&
      maximum_distance.to_s == (other[:maximum_distance]).to_s &&
      rate.to_s == (other[:rate]).to_s
  end
end
