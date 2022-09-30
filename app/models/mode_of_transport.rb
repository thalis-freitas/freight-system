class ModeOfTransport < ApplicationRecord
  validates :name, :minimum_distance, :maximum_distance, :minimum_weight, :maximum_weight, :flat_rate, presence: true

end
