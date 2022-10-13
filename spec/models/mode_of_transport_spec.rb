require 'rails_helper'

RSpec.describe ModeOfTransport, type: :model do
  describe '#valid' do
    context 'presence' do
      it 'nome não pode ficar em branco' do
        mode_of_transport = ModeOfTransport.new(name: '')
        mode_of_transport.valid?
        expect(mode_of_transport.errors.include? :name).to be true
        expect(mode_of_transport.errors[:name]).to include 'não pode ficar em branco'
      end

      it 'distância mínima não pode ficar em branco' do
        mode_of_transport = ModeOfTransport.new(minimum_distance: '')
        mode_of_transport.valid?
        expect(mode_of_transport.errors.include? :minimum_distance).to be true
        expect(mode_of_transport.errors[:minimum_distance]).to include 'não pode ficar em branco'
      end

      it 'distância máxima não pode ficar em branco' do
        mode_of_transport = ModeOfTransport.new(maximum_distance: '')
        mode_of_transport.valid?
        expect(mode_of_transport.errors.include? :maximum_distance).to be true
        expect(mode_of_transport.errors[:maximum_distance]).to include 'não pode ficar em branco'
      end

      it 'peso mínimo não pode ficar em branco' do
        mode_of_transport = ModeOfTransport.new(minimum_weight: '')
        mode_of_transport.valid?
        expect(mode_of_transport.errors.include? :minimum_weight).to be true
        expect(mode_of_transport.errors[:minimum_weight]).to include 'não pode ficar em branco'
      end

      it 'peso máximo não pode ficar em branco' do
        mode_of_transport = ModeOfTransport.new(maximum_weight: '')
        mode_of_transport.valid?
        expect(mode_of_transport.errors.include? :maximum_weight).to be true
        expect(mode_of_transport.errors[:maximum_weight]).to include 'não pode ficar em branco'
      end

      it 'taxa fixa não pode ficar em branco' do
        mode_of_transport = ModeOfTransport.new(flat_rate: '')
        mode_of_transport.valid?
        expect(mode_of_transport.errors.include? :flat_rate).to be true
        expect(mode_of_transport.errors[:flat_rate]).to include 'não pode ficar em branco'
      end
    end

    context 'comparison' do
      it 'distância máxima deve ser maior que 0' do
        mode_of_transport = ModeOfTransport.new(maximum_distance: '0')
        mode_of_transport.valid?
        expect(mode_of_transport.errors.include? :maximum_distance).to be true
        expect(mode_of_transport.errors[:maximum_distance]).to include 'deve ser maior que 0'
      end

      it 'peso máximo deve ser maior que 0' do
        mode_of_transport = ModeOfTransport.new(maximum_weight: '0')
        mode_of_transport.valid?
        expect(mode_of_transport.errors.include? :maximum_weight).to be true
        expect(mode_of_transport.errors[:maximum_weight]).to include 'deve ser maior que 0'
      end

      it 'distância mínima deve ser maior ou igual a 0' do 
        mode_of_transport = ModeOfTransport.new(minimum_distance: '-2')
        mode_of_transport.valid?
        expect(mode_of_transport.errors.include? :minimum_distance).to be true
        expect(mode_of_transport.errors[:minimum_distance]).to include 'deve ser maior ou igual a 0'
      end

      it 'peso mínimo deve ser maior ou igual a 0' do 
        mode_of_transport = ModeOfTransport.new(minimum_weight: '-10')
        mode_of_transport.valid?
        expect(mode_of_transport.errors.include? :minimum_weight).to be true
        expect(mode_of_transport.errors[:minimum_weight]).to include 'deve ser maior ou igual a 0'
      end

      it 'taxa fixa deve ser maior ou igual a 0' do 
        mode_of_transport = ModeOfTransport.new(flat_rate: '-10')
        mode_of_transport.valid?
        expect(mode_of_transport.errors.include? :flat_rate).to be true
        expect(mode_of_transport.errors[:flat_rate]).to include 'deve ser maior ou igual a 0'
      end
    end
  end

  describe '#inactive' do
    it 'a modalidade de transporte tem status inativo por padrão' do 
      mode_of_transport = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                                  minimum_weight: 20, maximum_weight: 800, flat_rate: 0) 
      expect(mode_of_transport.inactive?).to eq true
      expect(mode_of_transport.active?).to eq false
    end
  end

  describe '#==(other)' do
    it 'retorna true se os atributos forem iguais' do
      mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                  minimum_weight: 0, maximum_weight: 200, flat_rate: 1500)
      second_mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                         minimum_weight: 0, maximum_weight: 200, flat_rate: 1500)
    
      result = mode_of_transport == second_mode_of_transport  
      expect(result).to eq true
    end
  end
end
