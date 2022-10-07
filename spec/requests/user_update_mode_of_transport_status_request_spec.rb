require 'rails_helper'

describe 'Usuário atualiza status da modalidade de transporte' do
  it 'para inativa e não é admin' do
    mode_of_transport= ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                               minimum_weight: 0, maximum_weight: 200, flat_rate: 15, status: :active)
    user= User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    post(inactive_mode_of_transport_path(mode_of_transport.id))

    expect(response).to redirect_to root_path
  end

  it 'para ativa e não é admin' do
    mode_of_transport= ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                               minimum_weight: 0, maximum_weight: 200, flat_rate: 15, status: :active)
    user= User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    post(active_mode_of_transport_path(mode_of_transport.id))

    expect(response).to redirect_to root_path
  end
end