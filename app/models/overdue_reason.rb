class OverdueReason < ApplicationRecord
  belongs_to :service_order
  validates :overdue_reason, presence: :true
end
