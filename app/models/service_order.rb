class ServiceOrder < ApplicationRecord
  before_validation :generate_code, on: :create
  validates :product_code, length: { is: 17 }, allow_blank: true
  validates :height, :width, :depth, :weight, :total_distance, comparison: { greater_than: 0 }
  validates :recipient_phone, length: { in: 10..11 }, allow_blank: true
  validates :source_address, :product_code, :destination_address, :recipient, :recipient_phone, presence: true
  enum status: { pending: 0 }

  def ==(other)
    self.source_address == other[:source_address] &&
    self.product_code == other[:product_code] &&
    self.recipient == other[:recipient] && 
    self.destination_address == other[:destination_address] &&
    self.recipient_phone == other[:recipient_phone] && 
    "#{self.height}" == "#{other[:height]}" && 
    "#{self.width}" == "#{other[:width]}" && 
    "#{self.depth}" == "#{other[:depth]}" && 
    "#{self.weight}" == "#{other[:weight]}" && 
    "#{self.total_distance}" == "#{other[:total_distance]}"
  end

  private 
  
  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end
end
