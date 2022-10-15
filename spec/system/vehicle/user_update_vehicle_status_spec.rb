require 'rails_helper'

describe 'Usuário atualiza status do veículo' do 
  it 'se for admin' do 
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                              maximum_capacity: 23000)
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit vehicle_path(vehicle)
    expect(page).not_to have_button 'Marcar como em manutenção'
  end

  it 'a partir do menu' do 
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                              maximum_capacity: 23000)
    
    login_as admin                         
    visit root_path
    click_link 'Veículos'
    click_link 'HPK3528'
    expect(page).to have_button 'Marcar como em manutenção'
  end

  it 'com sucesso para em manutenção' do 
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                              maximum_capacity: 23000)
    
    login_as admin    
    visit vehicle_path(vehicle)
    click_button 'Marcar como em manutenção'

    expect(page).to have_content 'Status do Veículo atualizado para: Em manutenção'
    expect(page).not_to have_button 'Marcar como em manutenção'
    expect(page).to have_button 'Marcar como em operação'
  end

  it 'com sucesso para em operação' do 
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                              maximum_capacity: 23000, status: :in_maintenance)
    
    login_as admin    
    visit vehicle_path(vehicle)
    click_button 'Marcar como em operação'

    expect(page).to have_content 'Status do Veículo atualizado para: Em operação'
    expect(page).not_to have_button 'Marcar como em operação'
    expect(page).to have_button 'Marcar como em manutenção'
  end

  it 'se o status atual for diferente de em entrega' do 
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                              maximum_capacity: 23000, status: :on_delivery)
    login_as admin    
    visit vehicle_path(vehicle)
    expect(page).not_to have_button 'Marcar como em operação'
    expect(page).not_to have_button 'Marcar como em manutenção'
  end
end