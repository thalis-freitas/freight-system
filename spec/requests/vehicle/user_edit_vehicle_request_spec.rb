require 'rails_helper'

describe 'Usuário edita um veículo' do
  it 'sem estar autenticado' do
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E',
                              year_of_manufacture: '2011', maximum_capacity: 23_000)
    patch(vehicle_path(vehicle), params: { vehicle: { maximum_capacity: 40_000 } })
    expect(response).to redirect_to new_user_session_path
  end

  it 'e não é admin' do
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E',
                              year_of_manufacture: '2011', maximum_capacity: 23_000)
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    patch(vehicle_path(vehicle), params: { vehicle: { maximum_capacity: 40_000 } })
    expect(response).to redirect_to root_path
  end
end
