require 'rails_helper'

describe 'Usuário cadastra uma configuração de prazo para uma modalidade de transporte' do
  it 'sem estar autenticado' do
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20, maximum_distance: 2000,
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 1500,
                                                status: :active)
    deadline = Deadline.new
    post(mode_of_transport_deadlines_path(mode_of_transport, deadline), params: { deadline:
            { mode_of_transport:, minimum_distance: 20, maximum_distance: 1000,
              estimated_time: 1 } })
    expect(response).to redirect_to new_user_session_path
  end

  it 'e não é admin' do
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20, maximum_distance: 2000,
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 1500,
                                                status: :active)
    deadline = Deadline.new
    user = User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
    login_as user
    post(mode_of_transport_deadlines_path(mode_of_transport, deadline), params: { deadline:
            { mode_of_transport:, minimum_distance: 20, maximum_distance: 1000,
              estimated_time: 1 } })
    expect(response).to redirect_to root_path
  end
end
