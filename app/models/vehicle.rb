class Vehicle < ApplicationRecord
  validates :nameplate, :brand, :model, :year_of_manufacture, presence: true
  validates :year_of_manufacture, length: { is: 4 }, allow_blank: true
  validates :nameplate, length: { is: 7 }, allow_blank: true
  validates :maximum_capacity, comparison: { greater_than: 0 }
  validates :nameplate, uniqueness: true
  enum status: { in_operation: 0, in_maintenance: 5, on_delivery: 10 }

  def ==(other)
    nameplate == other[:nameplate] &&
      brand == other[:brand] &&
      model == other[:model] &&
      year_of_manufacture == other[:year_of_manufacture] &&
      maximum_capacity.to_i == (other[:maximum_capacity]).to_i
  end
end
