class ServiceOrder < ApplicationRecord
  has_one :initiate_service_order, dependent: nil
  has_one :mode_of_transport, through: :initiate_service_order
  has_one :associate_vehicle, dependent: nil
  has_one :vehicle, through: :associate_vehicle
  has_one :overdue_reason, dependent: nil
  before_validation :generate_code, on: :create
  validates :product_code, length: { is: 17 }, allow_blank: true
  validates :height, :width, :depth, :weight, :total_distance, comparison: { greater_than: 0 }
  validates :recipient_phone, length: { in: 10..11 }, allow_blank: true
  validates :source_address, :product_code, :destination_address, :recipient, :recipient_phone, presence: true
  enum status: { pending: 0, in_progress: 5, closed_on_deadline: 10, closed_in_arrears: 15 }

  def compare_dimensions(other)
    height.to_i == (other[:height]).to_i &&
      width.to_i == other[:width].to_i &&
      depth.to_i == (other[:depth]).to_i
  end

  def compare_weight_and_distance(other)
    weight.to_i == (other[:weight]).to_i &&
      total_distance.to_i == (other[:total_distance]).to_i
  end

  def ==(other)
    compare_dimensions(other) &&
      compare_weight_and_distance(other) &&
      source_address == other[:source_address] &&
      product_code == other[:product_code] &&
      recipient == other[:recipient] &&
      destination_address == other[:destination_address] &&
      recipient_phone == other[:recipient_phone]
  end

  def register_price_and_deadline
    update!(price: ModeOfTransportFinder.new(mode_of_transport, self).calculate_price,
            deadline: ModeOfTransportFinder.new(mode_of_transport, self).calculate_deadline)
  end

  def on_deadline?
    Time.current <= started_in + deadline.hours
  end

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end
end
