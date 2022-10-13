require 'rails_helper'

describe 'Usuário cadastra uma ordem de serviço' do
  it 'e não é admin' do
    service_order = ServiceOrder.new()
    user = User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
    login_as user
    post(service_orders_path(service_order), params: {service_order: 
      {source_address: 'Avenida Esbertalina Barbosa Damiani, 85 - São Mateus', product_code: 'AMROS-SMDNT-EPSLD',
      height: 200, width: 80, depth: 3, weight: 4, destination_address: 'Rua Tenente-Coronel Cardoso, 264 - Campos dos Goytacazes',
      recipient: 'Flávia Andrade', recipient_phone: '22996573849', total_distance: 480}})
    expect(response).to redirect_to root_path
  end
end