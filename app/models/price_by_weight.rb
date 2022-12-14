class PriceByWeight < ApplicationRecord
  belongs_to :mode_of_transport
  validates :minimum_weight, :maximum_weight, presence: true
  validates :value, comparison: { greater_than_or_equal_to: 0 }
  validate :validate_minimum_weight
  validate :validate_maximum_weight

  def ==(other)
    minimum_weight.to_s == (other[:minimum_weight]).to_s &&
      maximum_weight.to_s == (other[:maximum_weight]).to_s &&
      value.to_s == (other[:value]).to_s
  end

  def validate_minimum_weight
    return if minimum_weight.blank?

    if minimum_weight < mode_of_transport.minimum_weight
      errors.add(:minimum_weight, "deve ser maior ou igual a #{mode_of_transport.minimum_weight}")
    elsif minimum_weight >= mode_of_transport.maximum_weight
      errors.add(:minimum_weight, "deve ser menor que #{mode_of_transport.maximum_weight}")
    end
  end

  def validate_maximum_weight
    return if maximum_weight.blank?

    if maximum_weight > mode_of_transport.maximum_weight
      errors.add(:maximum_weight, "deve ser menor ou igual a #{mode_of_transport.maximum_weight}")
    elsif maximum_weight <= mode_of_transport.minimum_weight
      errors.add(:maximum_weight, "deve ser maior que #{mode_of_transport.minimum_weight}")
    end
  end
end
