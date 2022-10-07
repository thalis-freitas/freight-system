require 'rails_helper'

describe 'Usuário edita um veículo' do
  it 'e não é admin' do
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E',
                              year_of_manufacture: '2011', maximum_capacity: 23000)
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')

    login_as user
    patch(vehicle_path(vehicle.id), params: {vehicle: {maximum_capacity: 40000 }})

    expect(response).to redirect_to root_path
  end
end