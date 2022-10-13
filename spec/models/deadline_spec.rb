require 'rails_helper'

RSpec.describe Deadline, type: :model do
  describe '#valid' do
    context 'presence' do
      it 'distância mínima não pode ficar em branco' do
        deadline = Deadline.new(minimum_distance: '')
        deadline.valid?
        expect(deadline.errors.include? :minimum_distance).to be true
        expect(deadline.errors[:minimum_distance]).to include 'não pode ficar em branco'
      end

      it 'distância máxima não pode ficar em branco' do
        deadline = Deadline.new(maximum_distance: '')
        deadline.valid?
        expect(deadline.errors.include? :maximum_distance).to be true
        expect(deadline.errors[:maximum_distance]).to include 'não pode ficar em branco'
      end

      it 'taxa não pode ficar em branco' do
        deadline = Deadline.new(estimated_time: '')
        deadline.valid?
        expect(deadline.errors.include? :estimated_time).to be true
        expect(deadline.errors[:estimated_time]).to include 'não pode ficar em branco'
      end
    end
    
    context 'comparison' do 
      it 'prazo deve ser maior que 0' do 
        deadline = Deadline.new(estimated_time: '-5')
        deadline.valid?
        expect(deadline.errors.include? :estimated_time).to be true
        expect(deadline.errors[:estimated_time]).to include 'deve ser maior que 0'
      end
    end

    it 'distância máxima deve ser menor ou igual a distância máxima da modalidade de transporte' do
      mode_of_transport = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                                  minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)    
      deadline = Deadline.new(maximum_distance: '4900', mode_of_transport: mode_of_transport)
      deadline.valid?
      expect(deadline.errors.include? :maximum_distance).to be true
      expect(deadline.errors[:maximum_distance]).to include 'deve ser menor ou igual a 4000'
    end

    it 'distância máxima deve ser maior que distância mínima da modalidade de transporte' do
      mode_of_transport = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                                  minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)    
      deadline = Deadline.new(maximum_distance: '300', mode_of_transport: mode_of_transport)
      deadline.valid?
      expect(deadline.errors.include? :maximum_distance).to be true
      expect(deadline.errors[:maximum_distance]).to include 'deve ser maior que 500'
    end

    it 'distância mínima deve ser maior ou igual a distância mínima da modalidade de transporte' do 
      mode_of_transport = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                                  minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)  
      deadline = Deadline.new(minimum_distance: '200', mode_of_transport: mode_of_transport)
      deadline.valid?
      expect(deadline.errors.include? :minimum_distance).to be true
      expect(deadline.errors[:minimum_distance]).to include 'deve ser maior ou igual a 500'
    end

    it 'distância mínima deve ser menor que a distância máxima da modalidade de transporte' do 
      mode_of_transport = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                                  minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)  
      deadline = Deadline.new(minimum_distance: '4000', mode_of_transport: mode_of_transport)
      deadline.valid?
      expect(deadline.errors.include? :minimum_distance).to be true
      expect(deadline.errors[:minimum_distance]).to include 'deve ser menor que 4000'
    end
  end  

  describe '#==(other)' do
    it 'retorna true se os atributos forem iguais' do
      mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                  minimum_weight: 0, maximum_weight: 200, flat_rate: 1500)
      deadline = Deadline.create!(minimum_distance: 25, maximum_distance: 105, estimated_time: 3, 
                                  mode_of_transport: mode_of_transport) 
      second_deadline = Deadline.create!(minimum_distance: 25, maximum_distance: 105, estimated_time: 3, 
                                         mode_of_transport: mode_of_transport) 
      result = deadline == second_deadline
      expect(result).to eq true
    end
  end
end
