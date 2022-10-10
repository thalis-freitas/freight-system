class PriceByWeight < ApplicationRecord
  belongs_to :mode_of_transport
  validates :minimum_weight, :maximum_weight, presence: true
  validates :value, comparison: { greater_than_or_equal_to: 0 }
  validate :validate_minimum_weight
  validate :validate_maximum_weight

  def ==(other)
    "#{self.minimum_weight}"  == "#{other[:minimum_weight]}" && 
    "#{self.maximum_weight}"  == "#{other[:maximum_weight]}" && 
    "#{self.value}"  == "#{other[:value]}"
  end

  def validate_minimum_weight
    if self.minimum_weight.present? 
      if self.minimum_weight < self.mode_of_transport.minimum_weight
        self.errors.add(:minimum_weight, "deve ser maior ou igual a #{self.mode_of_transport.minimum_weight}")
      elsif self.minimum_weight >= self.mode_of_transport.maximum_weight
        self.errors.add(:minimum_weight, "deve ser menor que #{self.mode_of_transport.maximum_weight}")
      end
    end
  end

  def validate_maximum_weight
    if self.maximum_weight.present? 
      if self.maximum_weight > self.mode_of_transport.maximum_weight
        self.errors.add(:maximum_weight, "deve ser menor ou igual a #{self.mode_of_transport.maximum_weight}")
      elsif self.maximum_weight <= self.mode_of_transport.minimum_weight
        self.errors.add(:maximum_weight, "deve ser maior que #{self.mode_of_transport.minimum_weight}")
      end
    end
  end
end
