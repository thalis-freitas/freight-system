require 'rails_helper'

describe 'Usuário edita uma configuração de preço por peso para uma modalidade de transporte' do
  it 'e não é admin' do
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 500, flat_rate: 1500, status: :active)
    price_by_weight = PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 100, 
                                            mode_of_transport: mode_of_transport) 
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    patch(mode_of_transport_price_by_weight_path(mode_of_transport, price_by_weight), params: {price_by_weight: {value: 0 }})
    expect(response).to redirect_to root_path
  end
end