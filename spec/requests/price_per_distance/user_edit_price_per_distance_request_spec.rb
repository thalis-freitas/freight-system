require 'rails_helper'

describe 'Usuário edita uma configuração de preço por distância para uma modalidade de transporte' do
  it 'sem estar autenticado' do
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20,
                                                maximum_distance: 2000, minimum_weight: 0,
                                                maximum_weight: 500, flat_rate: 1500,
                                                status: :active)
    price_per_distance = PricePerDistance.create!(minimum_distance: 20, maximum_distance: 80, rate: 500,
                                                  mode_of_transport:)
    patch(mode_of_transport_price_per_distance_path(mode_of_transport, price_per_distance),
          params: { price_per_distance: { rate: 0 } })
    expect(response).to redirect_to new_user_session_path
  end

  it 'e não é admin' do
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20,
                                                maximum_distance: 2000, minimum_weight: 0,
                                                maximum_weight: 500, flat_rate: 1500,
                                                status: :active)
    price_per_distance = PricePerDistance.create!(minimum_distance: 20, maximum_distance: 80, rate: 500,
                                                  mode_of_transport:)
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    patch(mode_of_transport_price_per_distance_path(mode_of_transport, price_per_distance),
          params: { price_per_distance: { rate: 0 } })
    expect(response).to redirect_to root_path
  end
end
