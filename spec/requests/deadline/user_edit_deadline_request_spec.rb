require 'rails_helper'

describe 'Usuário edita uma configuração de prazo para uma modalidade de transporte' do
  it 'sem estar autenticado' do 
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 500, flat_rate: 1500, status: :active)
    deadline = Deadline.create!(minimum_distance: 25, maximum_distance: 105, estimated_time: 3, 
                                mode_of_transport: mode_of_transport)    
    patch(mode_of_transport_deadline_path(mode_of_transport, deadline), params: {deadline: {estimated_time: 1 }})
    expect(response).to redirect_to new_user_session_path
  end
  
  it 'e não é admin' do
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 500, flat_rate: 1500, status: :active)
    deadline = Deadline.create!(minimum_distance: 25, maximum_distance: 105, estimated_time: 3, 
                                mode_of_transport: mode_of_transport)    
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    patch(mode_of_transport_deadline_path(mode_of_transport, deadline), params: {deadline: {estimated_time: 1 }})
    expect(response).to redirect_to root_path
  end
end