class PricePerDistance < ApplicationRecord
  belongs_to :mode_of_transport
  validates :minimum_distance, :rate, comparison: { greater_than_or_equal_to: 0 }
  validates :maximum_distance, comparison: { greater_than: 0 }

  def ==(other)
    "#{self.minimum_distance}"  == "#{other[:minimum_distance]}" && 
    "#{self.maximum_distance}"  == "#{other[:maximum_distance]}" && 
    "#{self.rate}"  == "#{other[:rate]}"
  end
end
