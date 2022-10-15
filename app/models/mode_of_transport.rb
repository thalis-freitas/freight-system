class ModeOfTransport < ApplicationRecord
  has_many :price_by_weights
  has_many :price_per_distances
  has_many :deadlines
  has_many :service_orders, through: :initiate_service_order
  has_many :initiate_service_orders
  validates :name, presence: true
  validates :maximum_distance, :maximum_weight, comparison: { greater_than: 0 }
  validates :minimum_distance, :minimum_weight, :flat_rate, comparison: { greater_than_or_equal_to: 0 }
  enum status: { inactive: 0, active: 5 }

  def ==(other)
    self.name  == other[:name] &&
    "#{self.minimum_distance}"  == "#{other[:minimum_distance]}" && 
    "#{self.maximum_distance}"  == "#{other[:maximum_distance]}" && 
    "#{self.minimum_weight}"  == "#{other[:minimum_weight]}" && 
    "#{self.maximum_weight}"  == "#{other[:maximum_weight]}" && 
    "#{self.flat_rate}"  == "#{other[:flat_rate]}"
  end
end
