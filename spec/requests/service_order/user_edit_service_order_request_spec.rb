require 'rails_helper'

describe 'Usuário edita uma ordem de serviço' do
  it 'sem estar autenticado' do
    service_order = ServiceOrder.create!(source_address: 'Avenida Getúlio Vargas, 250 - Feira de Santana',
                                         product_code: 'MDKSJ-CADGM-ASM24', height: 120,
                                         width: 65, depth: 70, weight: 12,
                                         destination_address: 'Avenida São Rafael, 478 - Salvador',
                                         recipient: 'Joana Matos', recipient_phone: '71999284839',
                                         total_distance: 100)
    patch(service_order_path(service_order), params: { service_order: { total_distance: 200 } })
    expect(response).to redirect_to new_user_session_path
  end

  it 'e não é admin' do
    service_order = ServiceOrder.create!(source_address: 'Avenida Getúlio Vargas, 250 - Feira de Santana',
                                         product_code: 'MDKSJ-CADGM-ASM24', height: 120,
                                         width: 65, depth: 70, weight: 12,
                                         destination_address: 'Avenida São Rafael, 478 - Salvador',
                                         recipient: 'Joana Matos', recipient_phone: '71999284839',
                                         total_distance: 100)
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    patch(service_order_path(service_order), params: { service_order: { total_distance: 200 } })
    expect(response).to redirect_to root_path
  end

  it 'e status não é pendente' do
    service_order = ServiceOrder.create!(source_address: 'Avenida Getúlio Vargas, 250 - Feira de Santana',
                                         product_code: 'MDKSJ-CADGM-ASM24', height: 120,
                                         width: 65, depth: 70, weight: 12,
                                         destination_address: 'Avenida São Rafael, 478 - Salvador',
                                         recipient: 'Joana Matos', recipient_phone: '71999284839',
                                         total_distance: 100, status: :in_progress)
    admin = User.create!(name: 'Lara Machado', email: 'lara@sistemadefrete.com.br', password: 'pass1234', role: :admin)
    login_as admin
    patch(service_order_path(service_order), params: { service_order: { total_distance: 200 } })
    expect(response).to redirect_to root_path
  end
end
