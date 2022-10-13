require 'rails_helper'

describe 'Usuário cadastra modalidade de transporte' do
  it 'se estiver autenticado' do 
    visit new_mode_of_transport_path
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'se for admin' do 
    user = User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit mode_of_transports_path
    expect(page).not_to have_link 'Cadastrar Modalidade de Transporte'
  end

  it 'a partir da da url se for admin' do 
    user = User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
    login_as user 
    visit new_mode_of_transport_path
    expect(current_path).to eq root_path
    expect(page).to have_content 'Acesso não autorizado'
  end

  it 'a partir do menu' do
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)
    
    login_as admin
    visit root_path
    within('nav') do 
      click_link 'Modalidades de Transporte'
    end
    click_link 'Cadastrar Modalidade de Transporte'

    within('.form') do 
      expect(page).to have_field 'Nome'
      expect(page).to have_field 'Distância mínima', type: 'number'
      expect(page).to have_field 'Distância máxima', type: 'number'
      expect(page).to have_field 'Peso mínimo', type: 'number'
      expect(page).to have_field 'Peso máximo', type: 'number'
      expect(page).to have_field 'Taxa fixa (em centavos)', type: 'number'
      expect(page).to have_button 'Salvar'
    end
  end
  
  it 'com sucesso' do
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)
    
    login_as admin
    visit new_mode_of_transport_path
    fill_in 'Nome', with: 'Express'
    fill_in 'Distância mínima', with: '20'
    fill_in 'Distância máxima', with: '2000'
    fill_in 'Peso mínimo', with: '0'
    fill_in 'Peso máximo', with: '300'
    fill_in 'Taxa fixa (em centavos)', with: '1500'
    click_button 'Salvar'

    expect(page).to have_content 'Modalidade de Transporte cadastrada com sucesso'
    expect(page).to have_content 'Express'
    expect(page).to have_content 'Distância mínima: 20km'
    expect(page).to have_content 'Distância máxima: 2000km'
    expect(page).to have_content 'Peso mínimo: 0kg'
    expect(page).to have_content 'Peso máximo: 300kg'
    expect(page).to have_content 'Taxa fixa: R$ 15,00'
    expect(page).to have_content 'Situação atual: Inativa'
  end

  it 'com dados incompletos' do
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)
    
    login_as admin
    visit new_mode_of_transport_path
    fill_in 'Nome', with: ''
    fill_in 'Distância mínima', with: ''
    fill_in 'Peso mínimo', with: ''
    click_button 'Salvar'

    expect(page).to_not have_content 'Modalidade de Transporte cadastrada com sucesso'
    expect(page).to have_content 'Não foi possível cadastrar a Modalidade de Transporte'
    expect(page).to have_content 'Por favor verifique os erros abaixo'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Distância mínima não pode ficar em branco'
    expect(page).to have_content 'Distância máxima não pode ficar em branco'
    expect(page).to have_content 'Peso mínimo não pode ficar em branco'
    expect(page).to have_content 'Peso máximo não pode ficar em branco'
    expect(page).to have_content 'Taxa fixa não pode ficar em branco'
  end

  it 'com dados inválidos' do 
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)
    
    login_as admin
    visit new_mode_of_transport_path
    fill_in 'Distância mínima', with: '-1'
    fill_in 'Distância máxima', with: '0'
    fill_in 'Peso mínimo', with: '-2'
    fill_in 'Peso máximo', with: '0'
    fill_in 'Taxa fixa (em centavos)', with: '-5'
    click_button 'Salvar'

    expect(page).to have_content 'Distância mínima deve ser maior ou igual a 0'
    expect(page).to have_content 'Distância máxima deve ser maior que 0'
    expect(page).to have_content 'Peso máximo deve ser maior que 0'
    expect(page).to have_content 'Peso mínimo deve ser maior ou igual a 0'
    expect(page).to have_content 'Taxa fixa deve ser maior ou igual a 0'
  end
end
