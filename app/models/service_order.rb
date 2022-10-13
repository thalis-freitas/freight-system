class ServiceOrder < ApplicationRecord
  before_validation :generate_code, on: :create
  validates :product_code, length: { is: 17 }, allow_blank: true
  validates :height, :width, :depth, :weight, :total_distance, comparison: { greater_than: 0 }
  validates :recipient_phone, length: { in: 10..11 }, allow_blank: true
  validates :source_address, :product_code, :destination_address, :recipient, :recipient_phone, presence: true
  enum status: { pending: 0 }

  private 
  
  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end
end
