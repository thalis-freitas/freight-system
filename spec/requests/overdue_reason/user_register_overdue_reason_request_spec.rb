require 'rails_helper'

describe 'Usuário cadastra o motivo do atraso de uma ordem de serviço' do
  it 'sem estar autenticado' do
    economica = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                        minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)    
    PriceByWeight.create!(minimum_weight: 20, maximum_weight: 120, value: 0, mode_of_transport: economica)
    PricePerDistance.create!(minimum_distance: 1501, maximum_distance: 2500, rate: 380, mode_of_transport: economica)
    Deadline.create!(minimum_distance: 1001, maximum_distance: 2000, estimated_time: 336, mode_of_transport: economica)
    vehicle = Vehicle.create!(nameplate: 'ISX8398', brand: 'Mercedez Benz', model: '710 PLUS', year_of_manufacture: '2020',
                              maximum_capacity: 6700)
    service_order = ServiceOrder.create!(source_address: 'Avenida Tocantins, 384 - Jataí', product_code: 'SBDNF-PRIFM-SHFMD',
                                         height: 87, width: 135, depth: 38, weight: 55, destination_address: 'Zona Portuária, 30 - Rio Grande',
                                         recipient: 'Maurício Peixoto', recipient_phone: '53933204958', total_distance: 1730,
                                         mode_of_transport: economica, vehicle: vehicle, started_in: 1.week.ago, status: :in_progress)
    overdue_reason = OverdueReason.new()
    post(service_order_overdue_reasons_path(service_order), params: {overdue_reason: 
      {overdue_reason: 'Falhas na organização das rotas de entrega'}})
    expect(response).to redirect_to new_user_session_path 
  end
end