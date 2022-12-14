class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  enum role: { user: 0, admin: 5 }
  validates :name, presence: true
  validate :validate_email_domain

  def validate_email_domain
    return if email.end_with? '@sistemadefrete.com.br'

    errors.add(:email, 'inválido') if email != ''
  end
end
