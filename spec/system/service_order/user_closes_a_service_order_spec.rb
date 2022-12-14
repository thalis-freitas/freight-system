require 'rails_helper'

describe 'Usuário encerra uma ordem de serviço' do
  it 'se estiver autenticado' do
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
                                         vehicle:, started_in: 1.week.ago, status: :in_progress)
    service_order.register_price_and_deadline

    visit service_order_path(service_order)

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'dentro do prazo' do
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
                                         vehicle:, started_in: 1.week.ago, status: :in_progress)
    service_order.register_price_and_deadline
    user = User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')

    login_as user
    visit root_path
    click_link 'ABC123456789DEF'
    click_button 'Encerrar Ordem de Serviço'

    expect(page).not_to have_button 'Encerrar Ordem de Serviço'
    expect(page).not_to have_content 'Status: Em andamento'
    expect(page).to have_content "Iniciada em: #{I18n.l(1.week.ago, format: :short)}"
    expect(page).to have_content 'Preço: R$ 3,80'
    expect(page).to have_content 'Prazo: 14 dias'
    expect(page).to have_content 'Status: Encerrada no prazo'
    expect(page).to have_content "Encerrada em: #{I18n.l(Time.current, format: :short)}"
    expect(service_order.vehicle.status).to eq 'in_operation'
  end

  it 'e informa o motivo se estiver em atraso' do
    economica = ModeOfTransport.create!(name: 'Econômica', minimum_distance: 500, maximum_distance: 4000,
                                        minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)
    PriceByWeight.create!(minimum_weight: 20, maximum_weight: 120, value: 0, mode_of_transport: economica)
    PricePerDistance.create!(minimum_distance: 1501, maximum_distance: 2500, rate: 380, mode_of_transport: economica)
    Deadline.create!(minimum_distance: 1001, maximum_distance: 2000, estimated_time: 336, mode_of_transport: economica)
    vehicle = Vehicle.create!(nameplate: 'ISX8398', brand: 'Mercedez Benz', model: '710 PLUS',
                              year_of_manufacture: '2020', maximum_capacity: 6700)
    service_order = ServiceOrder.create!(source_address: 'Avenida Tocantins, 384 - Jataí',
                                         product_code: 'SBDNF-PRIFM-SHFMD', height: 87,
                                         width: 135, depth: 38, weight: 55,
                                         destination_address: 'Zona Portuária, 30 - Rio Grande',
                                         recipient: 'Maurício Peixoto', recipient_phone: '53933204958',
                                         total_distance: 1730, mode_of_transport: economica,
                                         vehicle:, started_in: 3.weeks.ago, status: :in_progress)
    service_order.register_price_and_deadline
    user = User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')

    login_as user
    visit service_order_path(service_order)
    click_link 'Registrar o motivo do atraso'
    fill_in 'Motivo do atraso', with: 'Falhas na comunicação com o motorista'
    click_button 'Salvar'

    expect(page).not_to have_button 'Registrar o motivo do atraso'
    expect(page).to have_content 'Motivo do atraso: Falhas na comunicação com o motorista'
    expect(page).to have_button 'Encerrar Ordem de Serviço em atraso'
  end

  it 'e informa o motivo do atraso se estiver autenticado' do
    economica = ModeOfTransport.create!(name: 'Econômica', minimum_distance: 500, maximum_distance: 4000,
                                        minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)
    PriceByWeight.create!(minimum_weight: 20, maximum_weight: 120, value: 0, mode_of_transport: economica)
    PricePerDistance.create!(minimum_distance: 1501, maximum_distance: 2500, rate: 380, mode_of_transport: economica)
    Deadline.create!(minimum_distance: 1001, maximum_distance: 2000, estimated_time: 336, mode_of_transport: economica)
    vehicle = Vehicle.create!(nameplate: 'ISX8398', brand: 'Mercedez Benz', model: '710 PLUS',
                              year_of_manufacture: '2020', maximum_capacity: 6700)
    service_order = ServiceOrder.create!(source_address: 'Avenida Tocantins, 384 - Jataí',
                                         product_code: 'SBDNF-PRIFM-SHFMD', height: 87,
                                         width: 135, depth: 38, weight: 55,
                                         destination_address: 'Zona Portuária, 30 - Rio Grande',
                                         recipient: 'Maurício Peixoto', recipient_phone: '53933204958',
                                         total_distance: 1730, mode_of_transport: economica,
                                         vehicle:, started_in: 3.weeks.ago, status: :in_progress)
    service_order.register_price_and_deadline
    User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')

    visit new_service_order_overdue_reason_path(service_order)
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'em atraso com sucesso' do
    economica = ModeOfTransport.create!(name: 'Econômica', minimum_distance: 500, maximum_distance: 4000,
                                        minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)
    PriceByWeight.create!(minimum_weight: 20, maximum_weight: 120, value: 0, mode_of_transport: economica)
    PricePerDistance.create!(minimum_distance: 1501, maximum_distance: 2500, rate: 380, mode_of_transport: economica)
    Deadline.create!(minimum_distance: 1001, maximum_distance: 2000, estimated_time: 336, mode_of_transport: economica)
    vehicle = Vehicle.create!(nameplate: 'ISX8398', brand: 'Mercedez Benz', model: '710 PLUS',
                              year_of_manufacture: '2020', maximum_capacity: 6700)
    service_order = ServiceOrder.create!(source_address: 'Avenida Tocantins, 384 - Jataí',
                                         product_code: 'SBDNF-PRIFM-SHFMD', height: 87,
                                         width: 135, depth: 38, weight: 55,
                                         destination_address: 'Zona Portuária, 30 - Rio Grande',
                                         recipient: 'Maurício Peixoto', recipient_phone: '53933204958',
                                         total_distance: 1730, mode_of_transport: economica,
                                         vehicle:, started_in: 3.weeks.ago, status: :in_progress)
    service_order.register_price_and_deadline
    overdue_reason = OverdueReason.create!(overdue_reason: 'Falhas na comunicação com o motorista',
                                           service_order:)
    service_order.overdue_reason = overdue_reason
    user = User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')

    login_as user
    visit service_order_path(service_order)
    click_button 'Encerrar Ordem de Serviço em atraso'

    expect(page).not_to have_button 'Encerrar Ordem de Serviço em atraso'
    expect(page).to have_content 'Status: Encerrada em atraso'
    expect(page).to have_content "Encerrada em: #{I18n.l(Time.current, format: :short)}"
    expect(page).to have_content 'Motivo do atraso: Falhas na comunicação com o motorista'
  end

  it 'e deixa o campo do motivo do atraso em branco' do
    economica = ModeOfTransport.create!(name: 'Econômica', minimum_distance: 500, maximum_distance: 4000,
                                        minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)
    PriceByWeight.create!(minimum_weight: 20, maximum_weight: 120, value: 0, mode_of_transport: economica)
    PricePerDistance.create!(minimum_distance: 1501, maximum_distance: 2500, rate: 380, mode_of_transport: economica)
    Deadline.create!(minimum_distance: 1001, maximum_distance: 2000, estimated_time: 336, mode_of_transport: economica)
    vehicle = Vehicle.create!(nameplate: 'ISX8398', brand: 'Mercedez Benz', model: '710 PLUS',
                              year_of_manufacture: '2020', maximum_capacity: 6700)
    service_order = ServiceOrder.create!(source_address: 'Avenida Tocantins, 384 - Jataí',
                                         product_code: 'SBDNF-PRIFM-SHFMD', height: 87,
                                         width: 135, depth: 38, weight: 55,
                                         destination_address: 'Zona Portuária, 30 - Rio Grande',
                                         recipient: 'Maurício Peixoto', recipient_phone: '53933204958',
                                         total_distance: 1730, mode_of_transport: economica,
                                         vehicle:, started_in: 3.weeks.ago, status: :in_progress)
    service_order.register_price_and_deadline
    user = User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')

    login_as user
    visit new_service_order_overdue_reason_path(service_order)
    fill_in 'Motivo do atraso', with: ''
    click_button 'Salvar'

    expect(page).to have_content 'Motivo do atraso não pode ficar em branco'
  end
end
