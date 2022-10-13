require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid' do
    context 'presence' do 
      it 'nome não pode ficar em branco' do
        user = User.new(name: '')
        user.valid?
        expect(user.errors.include? :name).to be true
        expect(user.errors[:name]).to include 'não pode ficar em branco'
      end

      it 'email não pode ficar em branco' do
        user = User.new(email: '')
        user.valid?
        expect(user.errors.include? :email).to be true
        expect(user.errors[:email]).to include 'não pode ficar em branco'
      end

      it 'password não pode ficar em branco' do
        user = User.new(password: '')
        user.valid?
        expect(user.errors.include? :password).to be true
        expect(user.errors[:password]).to include 'não pode ficar em branco'
      end
    end
  end

  describe '#validate_email_domain' do
    it 'email precisa ter domínio @sistemadefrete.com.br' do
      user = User.new(email: 'julia@email.com')
      user.valid?
      expect(user.errors.include? :email).to be true
      expect(user.errors[:email]).to include 'inválido'
    end
  end

  describe '#admin' do
    it 'usuário não tem função admin por padrão' do 
      user = User.create!(name: 'Julia Silva', email: 'julia@sistemadefrete.com.br', password:'password')
      expect(user.admin?).to eq false
    end
  end
end
