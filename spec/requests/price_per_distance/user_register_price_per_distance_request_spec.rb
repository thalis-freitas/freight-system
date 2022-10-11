require 'rails_helper'

describe 'Usuário cadastra uma configuração de preço por distância para uma modalidade de transporte' do
  it 'e não é admin' do
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 15, status: :active)
    price_per_distance = PricePerDistance.new
    user = User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
    login_as user
    post(price_per_distances_path(price_per_distance.id), params: {price_per_distance: {minimum_distance: 20, maximum_distance: 80,
                                                                                        rate: 0, mode_of_transport: mode_of_transport}})
    expect(response).to redirect_to root_path
  end
end