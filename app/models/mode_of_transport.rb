class ModeOfTransport < ApplicationRecord
  has_many :price_by_weights, dependent: nil
  has_many :price_per_distances, dependent: nil
  has_many :deadlines, dependent: nil
  has_many :service_orders, through: :initiate_service_order
  has_many :initiate_service_orders, dependent: nil
  validates :name, presence: true
  validates :maximum_distance, :maximum_weight, comparison: { greater_than: 0 }
  validates :minimum_distance, :minimum_weight, :flat_rate, comparison: { greater_than_or_equal_to: 0 }
  enum status: { inactive: 0, active: 5 }

  def compare_distance(other)
    minimum_distance.to_i == (other[:minimum_distance]).to_i &&
      maximum_distance.to_i == (other[:maximum_distance]).to_i
  end

  def compare_weight(other)
    minimum_weight.to_i == (other[:minimum_weight]).to_i &&
      maximum_weight.to_i == (other[:maximum_weight]).to_i
  end

  def ==(other)
    compare_distance(other) &&
      compare_weight(other) &&
      name == other[:name] &&
      flat_rate.to_i == (other[:flat_rate]).to_i
  end
end
