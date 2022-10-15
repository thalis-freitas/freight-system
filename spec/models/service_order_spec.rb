require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
  describe '#valid' do
    context 'presence' do
      it 'endereço de origem não pode ficar em branco' do
        service_order = ServiceOrder.new(source_address: '')
        service_order.valid?
        expect(service_order.errors.include? :source_address).to be true
        expect(service_order.errors[:source_address]).to include 'não pode ficar em branco'
      end
      it 'codigo do produto não pode ficar em branco' do
        service_order = ServiceOrder.new(product_code: '')
        service_order.valid?
        expect(service_order.errors.include? :product_code).to be true
        expect(service_order.errors[:product_code]).to include 'não pode ficar em branco'
      end
      it 'altura não pode ficar em branco' do
        service_order = ServiceOrder.new(height: '')
        service_order.valid?
        expect(service_order.errors.include? :height).to be true
        expect(service_order.errors[:height]).to include 'não pode ficar em branco'
      end
      it 'largura não pode ficar em branco' do
        service_order = ServiceOrder.new(width: '')
        service_order.valid?
        expect(service_order.errors.include? :width).to be true
        expect(service_order.errors[:width]).to include 'não pode ficar em branco'
      end
      it 'profundidade não pode ficar em branco' do
        service_order = ServiceOrder.new(depth: '')
        service_order.valid?
        expect(service_order.errors.include? :depth).to be true
        expect(service_order.errors[:depth]).to include 'não pode ficar em branco'
      end
      it 'endereço destino não pode ficar em branco' do
        service_order = ServiceOrder.new(destination_address: '')
        service_order.valid?
        expect(service_order.errors.include? :destination_address).to be true
        expect(service_order.errors[:destination_address]).to include 'não pode ficar em branco'
      end
      it 'nome do destinatário não pode ficar em branco' do
        service_order = ServiceOrder.new(recipient: '')
        service_order.valid?
        expect(service_order.errors.include? :recipient).to be true
        expect(service_order.errors[:recipient]).to include 'não pode ficar em branco'
      end
      it 'telefone não pode ficar em branco' do
        service_order = ServiceOrder.new(recipient_phone: '')
        service_order.valid?
        expect(service_order.errors.include? :recipient_phone).to be true
        expect(service_order.errors[:recipient_phone]).to include 'não pode ficar em branco'
      end
      it 'distância total não pode ficar em branco' do
        service_order = ServiceOrder.new(total_distance: '')
        service_order.valid?
        expect(service_order.errors.include? :total_distance).to be true
        expect(service_order.errors[:total_distance]).to include 'não pode ficar em branco'
      end
      it 'peso não pode ficar em branco' do
        service_order = ServiceOrder.new(weight: '')
        service_order.valid?
        expect(service_order.errors.include? :weight).to be true
        expect(service_order.errors[:weight]).to include 'não pode ficar em branco'
      end
    end

    context 'length' do
      it 'código do produto deve ter 17 caracteres' do
        service_order = ServiceOrder.new(product_code: 'abc')
        service_order.valid?
        expect(service_order.errors.include? :product_code).to be true
        expect(service_order.errors[:product_code]).to include 'não possui o tamanho esperado (17 caracteres)'
      end
      it 'telefone deve ter 10 ou 11 caracteres' do
        service_order = ServiceOrder.new(recipient_phone: '9283')
        service_order.valid?
        expect(service_order.errors.include? :recipient_phone).to be true
        expect(service_order.errors[:recipient_phone]).to include 'é muito curto (mínimo: 10 caracteres)'
      end
    end
    context 'comparison' do
      it 'altura deve ser maior que 0' do
        service_order = ServiceOrder.new(height: 0)
        service_order.valid?
        expect(service_order.errors.include? :height).to be true
        expect(service_order.errors[:height]).to include 'deve ser maior que 0'
      end
      it 'largura deve ser maior que 0' do
        service_order = ServiceOrder.new(width: -5)
        service_order.valid?
        expect(service_order.errors.include? :width).to be true
        expect(service_order.errors[:width]).to include 'deve ser maior que 0'
      end
      it 'profundidade deve ser maior que 0' do
        service_order = ServiceOrder.new(depth: -2)
        service_order.valid?
        expect(service_order.errors.include? :depth).to be true
        expect(service_order.errors[:depth]).to include 'deve ser maior que 0'
      end
      it 'peso deve ser maior que 0' do
        service_order = ServiceOrder.new(weight: 0)
        service_order.valid?
        expect(service_order.errors.include? :weight).to be true
        expect(service_order.errors[:weight]).to include 'deve ser maior que 0'
      end
      it 'distância total deve ser maior que 0' do
        service_order = ServiceOrder.new(total_distance: 0)
        service_order.valid?
        expect(service_order.errors.include? :total_distance).to be true
        expect(service_order.errors[:total_distance]).to include 'deve ser maior que 0'
      end
    end
  end

  describe '#pending' do
    it 'a ordem de serviço tem status pendente por padrão' do 
      service_order = ServiceOrder.create!(source_address: 'Rua Paracatu, 957 - São Paulo', product_code: 'AMDNF-EOLDF-SHNFK',
                                           height: 70, width: 40, depth: 30, weight: 2, destination_address: 'Rua da Imprensa, 48 - Gramado',
                                           recipient: 'João Cerqueira', recipient_phone: "54988475495", total_distance: 1120)
      expect(service_order.pending?).to eq true
    end
  end
  
  describe 'gera um código aleatório' do
    it 'ao criar uma ordem de serviço' do 
      service_order = ServiceOrder.create!(source_address: 'Rua Paracatu, 957 - São Paulo', product_code: 'AMDNF-EOLDF-SHNFK',
                                           height: 70, width: 40, depth: 30, weight: 2, destination_address: 'Rua da Imprensa, 48 - Gramado',
                                           recipient: 'João Cerqueira', recipient_phone: "54988475495", total_distance: 1120)
      expect(service_order.code).not_to be_empty
      expect(service_order.code.length).to eq 15
    end

    it 'e o código é único' do 
      service_order = ServiceOrder.create!(source_address: 'Rua Paracatu, 957 - São Paulo', product_code: 'AMDNF-EOLDF-SHNFK',
                                           height: 70, width: 40, depth: 30, weight: 2, destination_address: 'Rua da Imprensa, 48 - Gramado',
                                           recipient: 'João Cerqueira', recipient_phone: "54988475495", total_distance: 1120)
      second_service_order = ServiceOrder.new(source_address: 'Travessa Antônio Ferreira, 980 - Capanema', product_code: 'AANDM-OEHFM-SLDMF',
                                              height: 390, width: 248, depth: 383, weight: 3200, destination_address: 'Avenida Afonso Pena, 1029 - Belo Horizonte',
                                              recipient: 'Sofia dos Santos', recipient_phone: '31999483042', total_distance: 1615)
      second_service_order.save!
      expect(second_service_order.code).not_to eq service_order.code
    end

    it 'e não deve ser modificado' do
      service_order = ServiceOrder.create!(source_address: 'Rua Paracatu, 957 - São Paulo', product_code: 'AMDNF-EOLDF-SHNFK',
                                           height: 70, width: 40, depth: 30, weight: 2, destination_address: 'Rua da Imprensa, 48 - Gramado',
                                           recipient: 'João Cerqueira', recipient_phone: "54988475495", total_distance: 1120)
      original_code = service_order.code 
      service_order.update!(destination_address: 'Rua da Imprensa, 38 - Gramado')
      expect(service_order.code).to eq original_code
    end
  end
  
  describe '#==(other)' do
    it 'retorna true se os atributos forem iguais' do
      service_order = ServiceOrder.create!(source_address: 'Rua Paracatu, 957 - São Paulo', product_code: 'AMDNF-EOLDF-SHNFK',
                                           height: 70, width: 40, depth: 30, weight: 2, destination_address: 'Rua da Imprensa, 48 - Gramado',
                                           recipient: 'João Cerqueira', recipient_phone: "54988475495", total_distance: 1120)
      second_service_order = ServiceOrder.create!(source_address: 'Rua Paracatu, 957 - São Paulo', product_code: 'AMDNF-EOLDF-SHNFK',
                                                  height: 70, width: 40, depth: 30, weight: 2, destination_address: 'Rua da Imprensa, 48 - Gramado',
                                                  recipient: 'João Cerqueira', recipient_phone: "54988475495", total_distance: 1120)
      expect(service_order == second_service_order).to eq true
    end
  end

  describe '#register_price_and_deadline' do 
    it 'cadastra o preço e o prazo de uma ordem de serviço de acordo com a modalidade de transporte associada' do 
      economica = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                          minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)    
      PriceByWeight.create!(minimum_weight: 20, maximum_weight: 120, value: 0, mode_of_transport: economica)
      PricePerDistance.create!(minimum_distance: 1501, maximum_distance: 2500, rate: 380, mode_of_transport: economica)
      Deadline.create!(minimum_distance: 1001, maximum_distance: 2000, estimated_time: 336, mode_of_transport: economica)
      service_order = ServiceOrder.create!(source_address: 'Avenida Tocantins, 384 - Jataí', product_code: 'SBDNF-PRIFM-SHFMD',
                                           height: 87, width: 135, depth: 38, weight: 55, destination_address: 'Zona Portuária, 30 - Rio Grande',
                                           recipient: 'Maurício Peixoto', recipient_phone: '53933204958', total_distance: 1730,
                                           mode_of_transport: economica)
      service_order.register_price_and_deadline
      expect(service_order.price).to eq 380
      expect(service_order.deadline).to eq 336
    end
  end
end
