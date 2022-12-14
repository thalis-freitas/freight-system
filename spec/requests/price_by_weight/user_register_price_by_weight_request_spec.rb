require 'rails_helper'

describe 'Usuário cadastra uma configuração de preço por peso para uma modalidade de transporte' do
  it 'sem estar autenticado' do
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20, maximum_distance: 2000,
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 1500,
                                                status: :active)
    price_by_weight = PriceByWeight.new
    post(mode_of_transport_price_by_weights_path(mode_of_transport, price_by_weight), params: { price_by_weight:
      { minimum_weight: 0, maximum_weight: 50, value: 100, mode_of_transport: } })
    expect(response).to redirect_to new_user_session_path
  end

  it 'e não é admin' do
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20, maximum_distance: 2000,
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 1500,
                                                status: :active)
    price_by_weight = PriceByWeight.new
    user = User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
    login_as user
    post(mode_of_transport_price_by_weights_path(mode_of_transport, price_by_weight), params: { price_by_weight:
      { minimum_weight: 0, maximum_weight: 50, value: 100, mode_of_transport: } })
    expect(response).to redirect_to root_path
  end
end
