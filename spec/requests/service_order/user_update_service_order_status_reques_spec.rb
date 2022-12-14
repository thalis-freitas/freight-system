require 'rails_helper'

describe 'Usuário atualiza status da ordem de serviço' do
  it 'para em andamento sem estar autenticado' do
    service_order = ServiceOrder.create!(source_address: 'Avenida Getúlio Vargas, 250 - Feira de Santana',
                                         product_code: 'MDKSJ-CADGM-ASM24', height: 120,
                                         width: 65, depth: 70, weight: 12,
                                         destination_address: 'Avenida São Rafael, 478 - Salvador',
                                         recipient: 'Joana Matos', recipient_phone: '71999284839',
                                         total_distance: 100)
    post(in_progress_service_order_path(service_order))
    expect(response).to redirect_to new_user_session_path
  end

  it 'para encerrada no prazo sem estar autenticado' do
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
                                         vehicle:, started_in: 1.week.ago, status: :in_progress)
    service_order.register_price_and_deadline
    post(close_service_order_path(service_order))
    expect(response).to redirect_to new_user_session_path
  end

  it 'para encerrada em atraso somente se o motivo do atraso estiver presente' do
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
                                         vehicle:, started_in: 1.year.ago, status: :in_progress)
    user = User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')
    login_as user

    service_order.register_price_and_deadline
    post(close_overdue_service_order_path(service_order))
    expect(response).to redirect_to root_path
  end

  it 'para encerrada no prazo somente se estiver dentro do prazo' do
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
                                         vehicle:, started_in: 1.year.ago, status: :in_progress)
    user = User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')
    service_order.register_price_and_deadline

    login_as user
    post(close_service_order_path(service_order))
    expect(response).to redirect_to root_path
  end

  it 'para encerrada em atraso somente se estiver fora do prazo' do
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
                                         vehicle:, started_in: 1.day.ago, status: :in_progress)
    overdue_reason = OverdueReason.create!(overdue_reason: 'Engarrafamento', service_order:)
    service_order.overdue_reason = overdue_reason
    user = User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')
    service_order.register_price_and_deadline
    login_as user

    post(close_overdue_service_order_path(service_order))
    expect(response).to redirect_to root_path
  end
end
