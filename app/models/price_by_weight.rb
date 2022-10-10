class PriceByWeight < ApplicationRecord
  belongs_to :mode_of_transport
  validates :minimum_weight, :value, comparison: { greater_than_or_equal_to: 0 }
  validates :maximum_weight, comparison: { greater_than: 0 }

  def ==(other)
    "#{self.minimum_weight}"  == "#{other[:minimum_weight]}" && 
    "#{self.maximum_weight}"  == "#{other[:maximum_weight]}" && 
    "#{self.value}"  == "#{other[:value]}"
  end
end
