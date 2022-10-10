require 'rails_helper'

RSpec.describe PriceByWeight, type: :model do
  describe '#valid' do
    context 'presence' do
      it 'peso mínimo não pode ficar em branco' do
        price_by_weight = PriceByWeight.new(minimum_weight: '')
        price_by_weight.valid?
        expect(price_by_weight.errors.include? :minimum_weight).to be true
        expect(price_by_weight.errors[:minimum_weight]).to include 'não pode ficar em branco'
      end

      it 'peso máximo não pode ficar em branco' do
        price_by_weight = PriceByWeight.new(maximum_weight: '')
        price_by_weight.valid?
        expect(price_by_weight.errors.include? :maximum_weight).to be true
        expect(price_by_weight.errors[:maximum_weight]).to include 'não pode ficar em branco'
      end

      it 'valor por km não pode ficar em branco' do
        price_by_weight = PriceByWeight.new(value: '')
        price_by_weight.valid?
        expect(price_by_weight.errors.include? :value).to be true
        expect(price_by_weight.errors[:value]).to include 'não pode ficar em branco'
      end
    end
    context 'comparison' do
      it 'valor por km deve ser maior ou igual a 0' do 
        price_by_weight = PriceByWeight.new(value: '-15')
        price_by_weight.valid?
        expect(price_by_weight.errors.include? :value).to be true
        expect(price_by_weight.errors[:value]).to include 'deve ser maior ou igual a 0'
      end
    end

    it 'peso máximo deve ser menor ou igual ao peso máximo da modalidade de transporte' do
      mode_of_transport = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                                  minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)    
      price_by_weight = PriceByWeight.new(maximum_weight: '900', mode_of_transport: mode_of_transport)
      price_by_weight.valid?
      expect(price_by_weight.errors.include? :maximum_weight).to be true
      expect(price_by_weight.errors[:maximum_weight]).to include 'deve ser menor ou igual a 800'
    end

    it 'peso máximo deve ser maior que o peso mínimo da modalidade de transporte' do
      mode_of_transport = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                                  minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)    
      price_by_weight = PriceByWeight.new(maximum_weight: '10', mode_of_transport: mode_of_transport)
      price_by_weight.valid?
      expect(price_by_weight.errors.include? :maximum_weight).to be true
      expect(price_by_weight.errors[:maximum_weight]).to include 'deve ser maior que 20'
    end

    it 'peso mínimo deve ser maior ou igual ao peso mínimo da modalidade de transporte' do 
      mode_of_transport = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                                  minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)  
      price_by_weight = PriceByWeight.new(minimum_weight: '-5', mode_of_transport: mode_of_transport)
      price_by_weight.valid?
      expect(price_by_weight.errors.include? :minimum_weight).to be true
      expect(price_by_weight.errors[:minimum_weight]).to include 'deve ser maior ou igual a 20'
    end
    
    it 'peso mínimo deve ser menor que o peso máximo da modalidade de transporte' do 
      mode_of_transport = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                                  minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)  
      price_by_weight = PriceByWeight.new(minimum_weight: '1000', mode_of_transport: mode_of_transport)
      price_by_weight.valid?
      expect(price_by_weight.errors.include? :minimum_weight).to be true
      expect(price_by_weight.errors[:minimum_weight]).to include 'deve ser menor que 800'
    end
  end  

  describe '#==(other)' do
    it 'retorna true se os atributos forem iguais' do
      mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                  minimum_weight: 0, maximum_weight: 200, flat_rate: 15)
      price_by_weight = PriceByWeight.create!(minimum_weight: 10, maximum_weight: 40, value: 0, mode_of_transport: mode_of_transport)
      second_price_by_weight = PriceByWeight.create!(minimum_weight: 10, maximum_weight: 40, value: 0, mode_of_transport: mode_of_transport)
      result = price_by_weight == second_price_by_weight  
      expect(result).to eq true
    end
  end
end
