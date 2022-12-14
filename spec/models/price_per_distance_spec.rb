require 'rails_helper'

RSpec.describe PricePerDistance, type: :model do
  describe '#valid' do
    context 'presence' do
      it 'distância mínima não pode ficar em branco' do
        price_per_distance = PricePerDistance.new(minimum_distance: '')
        price_per_distance.valid?
        expect(price_per_distance.errors.include?(:minimum_distance)).to be true
        expect(price_per_distance.errors[:minimum_distance]).to include 'não pode ficar em branco'
      end

      it 'distância máxima não pode ficar em branco' do
        price_per_distance = PricePerDistance.new(maximum_distance: '')
        price_per_distance.valid?
        expect(price_per_distance.errors.include?(:maximum_distance)).to be true
        expect(price_per_distance.errors[:maximum_distance]).to include 'não pode ficar em branco'
      end

      it 'taxa não pode ficar em branco' do
        price_per_distance = PricePerDistance.new(rate: '')
        price_per_distance.valid?
        expect(price_per_distance.errors.include?(:rate)).to be true
        expect(price_per_distance.errors[:rate]).to include 'não pode ficar em branco'
      end
    end

    context 'comparison' do
      it 'taxa deve ser maior ou igual a 0' do
        price_per_distance = PricePerDistance.new(rate: '-5')
        price_per_distance.valid?
        expect(price_per_distance.errors.include?(:rate)).to be true
        expect(price_per_distance.errors[:rate]).to include 'deve ser maior ou igual a 0'
      end
    end

    it 'distância máxima deve ser menor ou igual a distância máxima da modalidade de transporte' do
      mode_of_transport = ModeOfTransport.create!(name: 'Econômica', minimum_distance: 500, maximum_distance: 4000,
                                                  minimum_weight: 20, maximum_weight: 800, flat_rate: 0,
                                                  status: :active)
      price_per_distance = PricePerDistance.new(maximum_distance: '4900', mode_of_transport:)
      price_per_distance.valid?
      expect(price_per_distance.errors.include?(:maximum_distance)).to be true
      expect(price_per_distance.errors[:maximum_distance]).to include 'deve ser menor ou igual a 4000'
    end

    it 'distância máxima deve ser maior que distância mínima da modalidade de transporte' do
      mode_of_transport = ModeOfTransport.create!(name: 'Econômica', minimum_distance: 500, maximum_distance: 4000,
                                                  minimum_weight: 20, maximum_weight: 800, flat_rate: 0,
                                                  status: :active)
      price_per_distance = PricePerDistance.new(maximum_distance: '300', mode_of_transport:)
      price_per_distance.valid?
      expect(price_per_distance.errors.include?(:maximum_distance)).to be true
      expect(price_per_distance.errors[:maximum_distance]).to include 'deve ser maior que 500'
    end

    it 'distância mínima deve ser maior ou igual a distância mínima da modalidade de transporte' do
      mode_of_transport = ModeOfTransport.create!(name: 'Econômica', minimum_distance: 500, maximum_distance: 4000,
                                                  minimum_weight: 20, maximum_weight: 800, flat_rate: 0,
                                                  status: :active)
      price_per_distance = PricePerDistance.new(minimum_distance: '200', mode_of_transport:)
      price_per_distance.valid?
      expect(price_per_distance.errors.include?(:minimum_distance)).to be true
      expect(price_per_distance.errors[:minimum_distance]).to include 'deve ser maior ou igual a 500'
    end

    it 'distância mínima deve ser menor que a distância máxima da modalidade de transporte' do
      mode_of_transport = ModeOfTransport.create!(name: 'Econômica', minimum_distance: 500, maximum_distance: 4000,
                                                  minimum_weight: 20, maximum_weight: 800, flat_rate: 0,
                                                  status: :active)
      price_per_distance = PricePerDistance.new(minimum_distance: '4000', mode_of_transport:)
      price_per_distance.valid?
      expect(price_per_distance.errors.include?(:minimum_distance)).to be true
      expect(price_per_distance.errors[:minimum_distance]).to include 'deve ser menor que 4000'
    end
  end
  describe '#==(other)' do
    it 'retorna true se os atributos forem iguais' do
      mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20, maximum_distance: 2000,
                                                  minimum_weight: 0, maximum_weight: 200, flat_rate: 1500)
      price_per_distance = PricePerDistance.create!(minimum_distance: 20, maximum_distance: 80, rate: 500,
                                                    mode_of_transport:)
      second_price_per_distance = PricePerDistance.create!(minimum_distance: 20, maximum_distance: 80, rate: 500,
                                                           mode_of_transport:)
      expect(price_per_distance == second_price_per_distance).to eq true
    end
  end
end
