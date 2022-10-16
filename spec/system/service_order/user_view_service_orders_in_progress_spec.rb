require 'rails_helper'

describe 'Usuário vê ordens de serviço em andamento' do 
  it 'na página inicial' do 
    express = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                      minimum_weight: 0, maximum_weight: 200, flat_rate: 1500, status: :active)
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 100, mode_of_transport: express)
    PricePerDistance.create!(minimum_distance: 21, maximum_distance: 150, rate: 850, mode_of_transport: express)
    Deadline.create!(minimum_distance: 20, maximum_distance: 100, estimated_time: 3, mode_of_transport: express)

    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789DEF')
    service_order = ServiceOrder.create!(source_address: 'Avenida Getúlio Vargas, 250 - Feira de Santana', product_code: 'MDKSJ-CADGM-ASM24',
                                         height: 120, width: 65, depth: 70, weight: 12, destination_address: 'Avenida São Rafael, 478 - Salvador',
                                         recipient: 'Joana Matos', recipient_phone: "71999284839", total_distance: 100,
                                         status: :in_progress, mode_of_transport: express, started_in: 16.hours.ago)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('123ABCDEFGHI456')
    second_service_order = ServiceOrder.create!(source_address: 'Rua José Pacheco, 25 - Maranguape', product_code: 'MDKSJ-RACKH-ASM24',
                                                height: 50, width: 120, depth: 40, weight: 8, destination_address: 'Rua Beatriz, 57 - Fortaleza',
                                                recipient: 'Joana Matos', recipient_phone: "85999284839", total_distance: 30,
                                                status: :in_progress, mode_of_transport: express, started_in: 1.day.ago)
    service_order.register_price_and_deadline
    second_service_order.register_price_and_deadline
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    
    login_as user
    visit root_path

    expect(page).to have_content 'Ordens de Serviço em andamento'
    expect(page).to have_link 'ABC123456789DEF'
    expect(page).to have_content 'Preço: R$ 123,50'
    expect(page).to have_content 'Prazo: 3 horas'
    expect(page).to have_content 'Modalidade: Express'
    expect(page).to have_link '123ABCDEFGHI456'
    expect(page).to have_content 'Preço: R$ 53,50'
    expect(page).to have_content 'Prazo: 3 horas'
    expect(page).to have_content 'Modalidade: Express'
  end

  it 'e não existem ordens de serviço em andamento' do 
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit root_path
    expect(page).to have_content 'Nenhuma ordem de serviço em andamento'
  end
end