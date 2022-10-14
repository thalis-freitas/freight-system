require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid' do
    context 'presence' do
      it 'modelo não pode ficar em branco' do
        vehicle = Vehicle.new(model: '')
        vehicle.valid?
        expect(vehicle.errors[:model]).to include 'não pode ficar em branco'
      end

      it 'marca não pode ficar em branco' do
        vehicle = Vehicle.new(brand: '')
        vehicle.valid?
        expect(vehicle.errors[:brand]).to include 'não pode ficar em branco'
      end

      it 'ano de fabricação não pode ficar em branco' do
        vehicle = Vehicle.new(year_of_manufacture: '')
        vehicle.valid?
        expect(vehicle.errors[:year_of_manufacture]).to include 'não pode ficar em branco'
      end

      it 'capacidade máxima não pode ficar em branco' do
        vehicle = Vehicle.new(maximum_capacity: '')
        vehicle.valid?
        expect(vehicle.errors[:maximum_capacity]).to include 'não pode ficar em branco'
      end
    end

    context 'length' do
      it 'ano de fabricação deve ter 4 caracteres' do 
        vehicle = Vehicle.new(year_of_manufacture: '11')
        vehicle.valid?
        expect(vehicle.errors[:year_of_manufacture]).to include 'não possui o tamanho esperado (4 caracteres)'
      end

      it 'placa de identificação deve ter 7 caracteres' do 
        vehicle = Vehicle.new(nameplate: 'MPV029374539')
        vehicle.valid?
        expect(vehicle.errors[:nameplate]).to include 'não possui o tamanho esperado (7 caracteres)'
      end
    end

    context 'comparison' do
      it 'capacidade máxima deve ser maior que 0' do 
        vehicle = Vehicle.new(maximum_capacity: '-5')
        vehicle.valid?
        expect(vehicle.errors[:maximum_capacity]).to include 'deve ser maior que 0'
      end
    end

    context 'uniqueness' do 
      it 'placa de identificação deve ser única' do 
        Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                        maximum_capacity: 23000)
        vehicle = Vehicle.new(nameplate: 'HPK3528')
        vehicle.valid?
        expect(vehicle.errors[:nameplate]).to include 'já está em uso'
      end
    end

    describe '#inactive' do
      it 'um veículo tem por padrão status em operação' do 
        vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                                  maximum_capacity: 23000)
        expect(vehicle.in_operation?).to eq true
        expect(vehicle.in_maintenance?).to eq false
      end
    end

    describe '#==(other)' do
      it 'retorna true se os atributos forem iguais' do
        vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                                  maximum_capacity: 23000)
        second_vehicle = Vehicle.new(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                                     maximum_capacity: 23000)
        expect(vehicle == second_vehicle).to eq true
      end
    end
  end
end
