class ValidateMinimumDistance < ActiveModel::Validator
  def validate(record)
    return if record.minimum_distance.blank?

    if record.minimum_distance < record.mode_of_transport.minimum_distance
      record.errors.add :minimum_distance, "deve ser maior ou igual a #{record.mode_of_transport.minimum_distance}"
    elsif record.minimum_distance >= record.mode_of_transport.maximum_distance
      record.errors.add :minimum_distance, "deve ser menor que #{record.mode_of_transport.maximum_distance}"
    end
  end
end

class PricePerDistance < ApplicationRecord
  include ActiveModel::Validations
end

class Deadline < ApplicationRecord
  include ActiveModel::Validations
end
