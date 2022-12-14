require 'rails_helper'

RSpec.describe OverdueReason, type: :model do
  describe '#valid' do
    it 'motivo do atraso não pode ficar em branco' do
      overdue_reason = OverdueReason.new(overdue_reason: '')
      overdue_reason.valid?
      expect(overdue_reason.errors.include?(:overdue_reason)).to be true
      expect(overdue_reason.errors[:overdue_reason]).to include 'não pode ficar em branco'
    end
  end
end
