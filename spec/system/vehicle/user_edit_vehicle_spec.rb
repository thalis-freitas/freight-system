require 'rails_helper'

describe 'Usuário edita um veículo' do 
  it 'se estiver autenticado' do 
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                              maximum_capacity: 23000)
    visit edit_vehicle_path(vehicle)
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'se for admin' do 
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                              maximum_capacity: 23000)
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit vehicle_path(vehicle)
    expect(page).not_to have_link 'Editar Modalidade de Transporte'
  end

  it 'a partir da url se for admin' do 
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                              maximum_capacity: 23000)
    user = User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
    login_as user 
    visit edit_vehicle_path(vehicle)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Acesso não autorizado'
  end

  it 'a partir do menu' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                              maximum_capacity: 23000)
    
    login_as admin                         
    visit root_path
    within('nav') do 
      click_link 'Veículos'
    end
    click_link 'HPK3528'
    click_link 'Editar Veículo'

    within('main form') do 
      expect(page).to have_field 'Modelo', with: 'Cargo 2428 E'
      expect(page).to have_field 'Marca', with: 'Ford'
      expect(page).to have_field 'Ano de fabricação', with: '2011'
      expect(page).to have_field 'Capacidade máxima', with: '23000'
      expect(page).to have_field 'Placa de identificação', with: 'HPK3528'
      expect(page).to have_button 'Salvar'
    end
  end

  it 'com sucesso' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                              maximum_capacity: 23000)

    login_as admin  
    visit edit_vehicle_path(vehicle)
    fill_in 'Modelo', with: 'ATEGO 1315'
    fill_in 'Marca', with: 'Mercedez Benz'
    fill_in 'Ano de fabricação', with: '2014'
    fill_in 'Capacidade máxima', with: '13000'
    fill_in 'Placa de identificação', with: 'AKL7566'
    click_button 'Salvar'

    expect(page).to have_content 'Veículo atualizado com sucesso'
    expect(page).to have_content 'AKL7566'
    expect(page).to have_content 'Marca: Mercedez Benz'
    expect(page).to have_content 'Ano de fabricação: 2014'
    expect(page).to have_content 'Modelo: ATEGO 1315'
    expect(page).to have_content 'Capacidade máxima: 13000kg'
  end

  it 'e deixa campos obrigatórios em branco' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                              maximum_capacity: 23000)

    login_as admin  
    visit edit_vehicle_path(vehicle)
    fill_in 'Modelo', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Ano de fabricação', with: ''
    fill_in 'Capacidade máxima', with: ''
    fill_in 'Placa de identificação', with: ''
    click_button 'Salvar'

    expect(page).to have_content 'Não foi possível atualizar o Veículo'
    expect(page).to have_content 'Por favor verifique os erros abaixo'
    expect(page).to have_content 'Modelo não pode ficar em branco'
    expect(page).to have_content 'Marca não pode ficar em branco'
    expect(page).to have_content 'Ano de fabricação não pode ficar em branco'
    expect(page).to have_content 'Capacidade máxima não pode ficar em branco'
    expect(page).to have_content 'Placa de identificação não pode ficar em branco'
    expect(page).not_to have_content 'Veículo atualizado com sucesso'
  end

  it 'com dados inválidos' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                              maximum_capacity: 23000)

    login_as admin  
    visit edit_vehicle_path(vehicle)
    fill_in 'Ano de fabricação', with: '20'
    fill_in 'Capacidade máxima', with: '0'
    fill_in 'Placa de identificação', with: 'HPM4820475'
    click_button 'Salvar'

    expect(page).to have_content 'Ano de fabricação não possui o tamanho esperado (4 caracteres)'
    expect(page).to have_content 'Capacidade máxima deve ser maior que 0'
    expect(page).to have_content 'Placa de identificação não possui o tamanho esperado (7 caracteres)'
  end

  it 'sem modificar os campos' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                              maximum_capacity: 23000)
    login_as admin  
    visit edit_vehicle_path(vehicle)
    click_button 'Salvar'
    expect(page).to have_content 'Nenhuma modificação encontrada'
  end

  it 'com placa de identificação que já está em uso' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    Vehicle.create!(nameplate: 'HQZ9585', brand: 'Volvo', model: 'VM 310', year_of_manufacture: '2016', 
                    maximum_capacity: 17500, status: :in_maintenance)
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                              maximum_capacity: 23000)
    login_as admin  
    visit edit_vehicle_path(vehicle)
    fill_in 'Placa de identificação', with: 'HQZ9585'
    click_button 'Salvar'

    expect(page).to have_content 'Por favor verifique o erro abaixo'
    expect(page).to have_content 'Placa de identificação já está em uso'
  end
end