require 'rails_helper'

describe 'Usuário atualiza status da ordem de serviço' do
  it 'para em andamento sem estar autenticado' do
    service_order = ServiceOrder.create!(source_address: 'Avenida Getúlio Vargas, 250 - Feira de Santana', product_code: 'MDKSJ-CADGM-ASM24',
                                         height: 120, width: 65, depth: 70, weight: 12, destination_address: 'Avenida São Rafael, 478 - Salvador',
                                         recipient: 'Joana Matos', recipient_phone: '71999284839', total_distance: 100)
    post(in_progress_service_order_path(service_order))
    expect(response).to redirect_to new_user_session_path
  end
end