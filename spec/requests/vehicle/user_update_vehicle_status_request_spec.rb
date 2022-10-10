require 'rails_helper'

describe 'Usuário atualiza status do veículo' do
  it 'para em manutenção e não é admin' do
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E',
                             year_of_manufacture: '2011', maximum_capacity: 23000)
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    post(in_maintenance_vehicle_path(vehicle.id))
    expect(response).to redirect_to root_path
  end

  it 'para em operação e não é admin' do
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E',
                              year_of_manufacture: '2011', maximum_capacity: 23000, status: :in_maintenance)
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    post(in_operation_vehicle_path(vehicle.id))
    expect(response).to redirect_to root_path
  end
end