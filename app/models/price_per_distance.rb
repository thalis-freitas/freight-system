class PricePerDistance < ApplicationRecord
  belongs_to :mode_of_transport
  validates :minimum_distance, :maximum_distance, presence: true
  validates :rate, comparison: { greater_than_or_equal_to: 0 }
  validate :validate_minimum_distance
  validate :validate_maximum_distance

  def ==(other)
    "#{self.minimum_distance}"  == "#{other[:minimum_distance]}" && 
    "#{self.maximum_distance}"  == "#{other[:maximum_distance]}" && 
    "#{self.rate}"  == "#{other[:rate]}"
  end

  def validate_minimum_distance
    if self.minimum_distance.present? 
      if self.minimum_distance < self.mode_of_transport.minimum_distance
        self.errors.add(:minimum_distance, "deve ser maior ou igual a #{self.mode_of_transport.minimum_distance}")
      elsif self.minimum_distance >= self.mode_of_transport.maximum_distance
        self.errors.add(:minimum_distance, "deve ser menor que #{self.mode_of_transport.maximum_distance}")
      end
    end
  end

  def validate_maximum_distance
    if self.maximum_distance.present? 
      if self.maximum_distance > self.mode_of_transport.maximum_distance
        self.errors.add(:maximum_distance, "deve ser menor ou igual a #{self.mode_of_transport.maximum_distance}")
      elsif self.maximum_distance <= self.mode_of_transport.minimum_distance
        self.errors.add(:maximum_distance, "deve ser maior que #{self.mode_of_transport.minimum_distance}")
      end
    end
  end
end
