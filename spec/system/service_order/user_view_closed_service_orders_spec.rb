require 'rails_helper'

describe 'Usuário vê ordens de serviço encerradas' do
  it 'se estiver autenticado' do
    visit root_path
    expect(page).not_to have_link 'Ordens de Serviço encerradas'
  end

  it 'a partir da página inicial' do
    user = User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')
    login_as user
    visit root_path
    expect(page).to have_link 'Ordens de Serviço encerradas'
  end

  it 'a partir da url se estiver autenticado' do
    visit closeds_service_orders_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'com sucesso' do
    economica = ModeOfTransport.create!(name: 'Econômica', minimum_distance: 500, maximum_distance: 4000,
                                        minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)
    PriceByWeight.create!(minimum_weight: 20, maximum_weight: 120, value: 0, mode_of_transport: economica)
    PricePerDistance.create!(minimum_distance: 1501, maximum_distance: 2500, rate: 380, mode_of_transport: economica)
    Deadline.create!(minimum_distance: 1001, maximum_distance: 2000, estimated_time: 336, mode_of_transport: economica)
    vehicle = Vehicle.create!(nameplate: 'ISX8398', brand: 'Mercedez Benz', model: '710 PLUS',
                              year_of_manufacture: '2020', maximum_capacity: 6700)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789DEF')
    service_order = ServiceOrder.create!(source_address: 'Avenida Tocantins, 384 - Jataí',
                                         product_code: 'SBDNF-PRIFM-SHFMD', height: 87,
                                         width: 135, depth: 38, weight: 55,
                                         destination_address: 'Zona Portuária, 30 - Rio Grande',
                                         recipient: 'Maurício Peixoto', recipient_phone: '53933204958',
                                         total_distance: 1730, mode_of_transport: economica,
                                         vehicle:, started_in: 1.week.ago,
                                         closed_in: 1.day.ago, status: :closed_on_deadline)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('123456789ABCDEF')
    second_service_order = ServiceOrder.create!(source_address: 'Avenida Rio Branco, 482 - Jataí',
                                                product_code: 'SBDNF-PRIFM-SHFMD', height: 87,
                                                width: 135, depth: 38, weight: 55,
                                                destination_address: 'Zona Portuária, 30 - Rio Grande',
                                                recipient: 'Julia Menezes', recipient_phone: '53933204958',
                                                total_distance: 1730, mode_of_transport: economica,
                                                vehicle:, started_in: 2.months.ago, closed_in: 1.day.ago,
                                                status: :closed_in_arrears)
    service_order.register_price_and_deadline
    second_service_order.register_price_and_deadline
    user = User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')

    login_as user
    visit closeds_service_orders_path
    expect(page).to have_content 'Ordens de Serviço encerradas'
    expect(page).to have_content 'ABC123456789DEF'
    expect(page).to have_content 'Status: Encerrada no prazo'
    expect(page).to have_content '123456789ABCDEF'
    expect(page).to have_content 'Status: Encerrada em atraso'
    expect(page).to have_link 'ISX8398'
    expect(page).to have_link 'Econômica'
  end

  it 'e não existem ordens de serviço encerradas' do
    user = User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')

    login_as user
    visit closeds_service_orders_path
    expect(page).to have_content 'Nenhuma ordem de serviço encerrada'
  end
end
