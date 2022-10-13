class ValidateMaximumDistance < ActiveModel::Validator
  def validate record
    if record.maximum_distance.present?
      if record.maximum_distance > record.mode_of_transport.maximum_distance
        record.errors.add :maximum_distance, "deve ser menor ou igual a #{record.mode_of_transport.maximum_distance}"
      elsif record.maximum_distance <= record.mode_of_transport.minimum_distance
        record.errors.add :maximum_distance, "deve ser maior que #{record.mode_of_transport.minimum_distance}"
      end
    end
  end
end

class PricePerDistance < ApplicationRecord
  include ActiveModel::Validations
end

class Deadline < ApplicationRecord
  include ActiveModel::Validations
end