require 'rails_helper'

describe 'Usuário inicia uma ordem serviço pendente' do 
  it 'a partir da página inicial' do 
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789DEF')
    ServiceOrder.create!(source_address: 'Avenida Tocantins, 384 - Jataí', product_code: 'SBDNF-PRIFM-SHFMD',
                         height: 87, width: 135, depth: 38, weight: 55, destination_address: 'Zona Portuária, 30 - Rio Grande',
                         recipient: 'Maurício Peixoto', recipient_phone: '53933204958', total_distance: 1730)
    economica = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                        minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)    
    PriceByWeight.create!(minimum_weight: 20, maximum_weight: 120, value: 0, mode_of_transport: economica)
    PricePerDistance.create!(minimum_distance: 1501, maximum_distance: 2500, rate: 380, mode_of_transport: economica)
    Deadline.create!(minimum_distance: 1001, maximum_distance: 2000, estimated_time: 336, mode_of_transport: economica)

    disk_envios = ModeOfTransport.create!(name:'Disk Envios', minimum_distance: 800, maximum_distance: 5000, 
                                minimum_weight: 30, maximum_weight: 1000, flat_rate: 850, status: :active)     
    PriceByWeight.create!(minimum_weight: 30, maximum_weight: 200, value: 10, mode_of_transport: disk_envios)
    PricePerDistance.create!(minimum_distance: 800, maximum_distance: 2000, rate: 1000, mode_of_transport: disk_envios)
    Deadline.create!(minimum_distance: 1501, maximum_distance: 2000, estimated_time: 144, mode_of_transport: disk_envios)

    user = User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')

    login_as user 
    visit root_path 
    click_link 'ABC123456789DEF'
    
    expect(page).to have_content 'Econômica'
    expect(page).to have_content 'Disk Envios'
    expect(page).to have_button 'Iniciar Ordem de Serviço'
    expect(page).not_to have_button 'Encerrar Ordem de Serviço'
  end

  it 'com sucesso' do 
    service_order = ServiceOrder.create!(source_address: 'Avenida Tocantins, 384 - Jataí', product_code: 'SBDNF-PRIFM-SHFMD',
                                         height: 87, width: 135, depth: 38, weight: 55, destination_address: 'Zona Portuária, 30 - Rio Grande',
                                         recipient: 'Maurício Peixoto', recipient_phone: '53933204958', total_distance: 1730)
    economica = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                        minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)    
    PriceByWeight.create!(minimum_weight: 20, maximum_weight: 120, value: 0, mode_of_transport: economica)
    PricePerDistance.create!(minimum_distance: 1501, maximum_distance: 2500, rate: 380, mode_of_transport: economica)
    Deadline.create!(minimum_distance: 1001, maximum_distance: 2000, estimated_time: 336, mode_of_transport: economica)

    disk_envios = ModeOfTransport.create!(name:'Disk Envios', minimum_distance: 800, maximum_distance: 5000, 
                                minimum_weight: 30, maximum_weight: 1000, flat_rate: 850, status: :active)     
    PriceByWeight.create!(minimum_weight: 30, maximum_weight: 200, value: 10, mode_of_transport: disk_envios)
    PricePerDistance.create!(minimum_distance: 800, maximum_distance: 2000, rate: 1000, mode_of_transport: disk_envios)
    Deadline.create!(minimum_distance: 1501, maximum_distance: 2000, estimated_time: 144, mode_of_transport: disk_envios)

    user = User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')
    vehicle = Vehicle.create!(nameplate: 'ISX8398', brand: 'Mercedez Benz', model: '710 PLUS', year_of_manufacture: '2020',
                              maximum_capacity: 6700)

    login_as user                 
    visit service_order_path(service_order)
    select 'Econômica', from: 'Modalidade de Transporte'
    click_button 'Iniciar Ordem de Serviço'

    expect(page).to have_content 'Status: Em andamento'
    expect(page).to have_content 'Modalidade de Transporte: Econômica'
    expect(page).to have_link 'Econômica'
    expect(page).to have_content 'Preço: R$ 3,80'
    expect(page).to have_content 'Prazo: 14 dias'
    expect(page).to have_content 'Veículo: ISX8398'
    expect(page).to have_link 'ISX8398'
    expect(page).to have_content "Iniciada em: #{I18n.l(Time.current, format: :short)}"
    expect(page).to have_button 'Encerrar Ordem de Serviço'
    expect(page).not_to have_button 'Iniciar Ordem de Serviço'
    expect(service_order.vehicle.status).to eq 'on_delivery'
  end

  it 'e não existem veículos aptos para fazer a entrega' do 
    service_order = ServiceOrder.create!(source_address: 'Avenida Tocantins, 384 - Jataí', product_code: 'SBDNF-PRIFM-SHFMD',
                                         height: 87, width: 135, depth: 38, weight: 55, destination_address: 'Zona Portuária, 30 - Rio Grande',
                                         recipient: 'Maurício Peixoto', recipient_phone: '53933204958', total_distance: 1730)
    economica = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                        minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)    
    PriceByWeight.create!(minimum_weight: 20, maximum_weight: 120, value: 0, mode_of_transport: economica)
    PricePerDistance.create!(minimum_distance: 1501, maximum_distance: 2500, rate: 380, mode_of_transport: economica)
    Deadline.create!(minimum_distance: 1001, maximum_distance: 2000, estimated_time: 336, mode_of_transport: economica)
    user = User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')

    login_as user                 
    visit service_order_path(service_order)
    select 'Econômica', from: 'Modalidade de Transporte'
    click_button 'Iniciar Ordem de Serviço'

    expect(page).to have_content 'Ops, nenhum veículo disponível para atender esta Ordem de Serviço'
  end
end