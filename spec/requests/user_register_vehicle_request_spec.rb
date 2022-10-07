require 'rails_helper'

describe 'Usuário cadastra um veículo' do
  it 'e não é admin' do
    vehicle = Vehicle.new()
    user = User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
    login_as user
    post(vehicles_path(vehicle.id), params: {vehicle: {nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                                                       maximum_capacity: 23000}})
    expect(response).to redirect_to root_path
  end
end