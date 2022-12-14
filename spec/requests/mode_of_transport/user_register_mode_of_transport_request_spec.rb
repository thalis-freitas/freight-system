require 'rails_helper'

describe 'Usuário cadastra uma modalidade de transporte' do
  it 'sem estar autenticado' do
    mode_of_transport = ModeOfTransport.new
    post(mode_of_transports_path(mode_of_transport), params: { mode_of_transport:
      { name: 'Express', minimum_distance: 20, maximum_distance: 2000, minimum_weight: 0, maximum_weight: 500,
        flat_rate: 1500, status: :active } })
    expect(response).to redirect_to new_user_session_path
  end

  it 'e não é admin' do
    mode_of_transport = ModeOfTransport.new
    user = User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
    login_as user
    post(mode_of_transports_path(mode_of_transport), params: { mode_of_transport:
      { name: 'Express', minimum_distance: 20, maximum_distance: 2000, minimum_weight: 0, maximum_weight: 500,
        flat_rate: 1500, status: :active } })
    expect(response).to redirect_to root_path
  end
end
