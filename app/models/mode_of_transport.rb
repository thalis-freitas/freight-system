class ModeOfTransport < ApplicationRecord
  validates :name, :minimum_distance, :maximum_distance, :minimum_weight, :maximum_weight, :flat_rate, presence: true
  validates :maximum_distance, :maximum_weight, comparison: { greater_than: 0 }, allow_blank: true
  validates :minimum_distance, :minimum_weight, :flat_rate, comparison: { greater_than_or_equal_to: 0 }, allow_blank: true
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
