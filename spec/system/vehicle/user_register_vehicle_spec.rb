require 'rails_helper'

describe 'Usuário cadastra um veículo' do
  it 'se estiver autenticado' do
    visit new_vehicle_path
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'se for admin' do
    user = User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit vehicles_path
    expect(page).not_to have_link 'Cadastrar Veículo'
  end

  it 'a partir da url se for admin' do
    user = User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit new_vehicle_path
    expect(current_path).to eq root_path
    expect(page).to have_content 'Acesso não autorizado'
  end

  it 'a partir do menu' do
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password',
                         role: :admin)

    login_as admin
    visit root_path
    within('nav') do
      click_link 'Veículos'
    end
    click_link 'Cadastrar Veículo'

    within('main form') do
      expect(page).to have_field 'Modelo'
      expect(page).to have_field 'Marca'
      expect(page).to have_field 'Ano de fabricação', type: 'number'
      expect(page).to have_field 'Capacidade máxima', type: 'number'
      expect(page).to have_field 'Placa de identificação'
      expect(page).to have_button 'Salvar'
    end
  end

  it 'com sucesso' do
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password',
                         role: :admin)

    login_as admin
    visit new_vehicle_path
    fill_in 'Modelo', with: 'Cargo 2428 E'
    fill_in 'Marca', with: 'Ford'
    fill_in 'Ano de fabricação', with: '2011'
    fill_in 'Capacidade máxima', with: '23000'
    fill_in 'Placa de identificação', with: 'hpk3528'
    click_button 'Salvar'

    expect(page).to have_content 'Veículo cadastrado com sucesso'
    expect(page).to have_content 'HPK3528'
    expect(page).to have_content 'Marca: Ford'
    expect(page).to have_content 'Ano de fabricação: 2011'
    expect(page).to have_content 'Capacidade máxima: 23000kg'
    expect(page).to have_content 'Modelo: Cargo 2428 E'
    expect(page).to have_content 'Status: Em operação'
  end

  it 'com dados incompletos' do
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password',
                         role: :admin)

    login_as admin
    visit new_vehicle_path
    fill_in 'Modelo', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Ano de fabricação', with: ''
    fill_in 'Capacidade máxima', with: ' '
    fill_in 'Placa de identificação', with: ''
    click_button 'Salvar'

    expect(page).to_not have_content 'Veículo cadastrado com sucesso'
    expect(page).to have_content 'Não foi possível cadastrar o Veículo'
    expect(page).to have_content 'Por favor verifique os erros abaixo'
    expect(page).to have_content 'Modelo não pode ficar em branco'
    expect(page).to have_content 'Marca não pode ficar em branco'
    expect(page).to have_content 'Ano de fabricação não pode ficar em branco'
    expect(page).to have_content 'Capacidade máxima não pode ficar em branco'
    expect(page).to have_content 'Placa de identificação não pode ficar em branco'
  end

  it 'com dados inválidos' do
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password',
                         role: :admin)

    login_as admin
    visit new_vehicle_path
    fill_in 'Ano de fabricação', with: '99'
    fill_in 'Capacidade máxima', with: '-2'
    fill_in 'Placa de identificação', with: 'HPM'
    click_button 'Salvar'

    expect(page).to have_content 'Ano de fabricação não possui o tamanho esperado (4 caracteres)'
    expect(page).to have_content 'Capacidade máxima deve ser maior que 0'
    expect(page).to have_content 'Placa de identificação não possui o tamanho esperado (7 caracteres)'
  end

  it 'com placa de identificação que já está em uso' do
    Vehicle.create!(nameplate: 'KER0414', brand: 'Volks', model: 'Constelallation 17.250', year_of_manufacture: '2012',
                    maximum_capacity: 16_000)
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password',
                         role: :admin)

    login_as admin
    visit new_vehicle_path
    fill_in 'Placa de identificação', with: 'KER0414'
    click_button 'Salvar'

    expect(page).to have_content 'Placa de identificação já está em uso'
  end
end
