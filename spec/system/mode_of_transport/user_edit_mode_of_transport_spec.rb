require 'rails_helper'

describe 'Usuário edita uma modalidade de transporte' do 
  it 'se estiver autenticado' do 
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: 'active')
    visit edit_mode_of_transport_path(mode_of_transport)
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'se for admin' do 
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: 'active')
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit mode_of_transport_path(mode_of_transport)
    expect(page).not_to have_link 'Editar Modalidade de Transporte'
  end

  it 'a partir da da url se for admin' do 
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: 'active')
    user = User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
    login_as user 
    visit edit_mode_of_transport_path(mode_of_transport)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Acesso não autorizado'
  end

  it 'a partir do menu' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: 'admin')
    ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                            minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: 'active')
    
    login_as admin                         
    visit root_path
    within('nav') do 
      click_link 'Modalidades de Transporte'
    end
    click_link 'Express'
    click_link 'Editar Modalidade de Transporte'

    within('.form') do 
      expect(page).to have_field 'Nome', with: 'Express'
      expect(page).to have_field 'Distância mínima', with: '20'
      expect(page).to have_field 'Distância máxima', with: '2000'
      expect(page).to have_field 'Peso mínimo', with: '0'
      expect(page).to have_field 'Peso máximo', with: '500'
      expect(page).to have_field 'Taxa fixa', with: '15'
    end
  end

  it 'com sucesso' do
    ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                            minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: 'active')
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: 'admin')
    
    login_as admin  
    visit mode_of_transports_path
    click_link 'Express'
    click_link 'Editar Modalidade de Transporte'
    fill_in 'Nome', with: 'Rapidex'
    fill_in 'Distância mínima', with: '0'
    fill_in 'Distância máxima', with: '1400'
    fill_in 'Peso mínimo', with: '5'
    fill_in 'Peso máximo', with: '600'
    fill_in 'Taxa fixa', with: '13'
    click_button 'Salvar'

    expect(page).to have_content 'Modalidade de Transporte atualizada com sucesso'
    expect(page).to have_content 'Rapidex'
    expect(page).to have_content 'Distância mínima: 0km'
    expect(page).to have_content 'Distância máxima: 1400km'
    expect(page).to have_content 'Peso mínimo: 5kg'
    expect(page).to have_content 'Peso máximo: 600kg'
    expect(page).to have_content 'Taxa fixa: R$ 13,00'
    expect(page).not_to have_content 'Express'
  end

  it 'e deixa campos obrigatórios em branco' do
    ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                            minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: 'active')
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: 'admin')
    
    login_as admin  
                      
    visit mode_of_transports_path
    click_link 'Express'
    click_link 'Editar Modalidade de Transporte'
    fill_in 'Nome', with: ''
    fill_in 'Distância mínima', with: ''
    fill_in 'Distância máxima', with: ''
    fill_in 'Peso mínimo', with: ''
    fill_in 'Peso máximo', with: ''
    fill_in 'Taxa fixa', with: ''
    click_button 'Salvar'

    expect(page).to have_content 'Não foi possível atualizar a Modalidade de Transporte'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Distância mínima não pode ficar em branco'
    expect(page).to have_content 'Distância máxima não pode ficar em branco'
    expect(page).to have_content 'Peso mínimo não pode ficar em branco'
    expect(page).to have_content 'Peso máximo não pode ficar em branco'
    expect(page).to have_content 'Taxa fixa não pode ficar em branco'
    expect(page).to_not have_content 'Modalidade de Transporte cadastrada com sucesso'
  end

  it 'com dados inválidos' do
    ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                            minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: 'active')
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: 'admin')
    
    login_as admin  
    visit mode_of_transports_path
    click_link 'Express'
    click_link 'Editar Modalidade de Transporte'
    fill_in 'Distância mínima', with: '-4'
    fill_in 'Distância máxima', with: '0'
    fill_in 'Peso mínimo', with: '-2'
    fill_in 'Peso máximo', with: '0'
    fill_in 'Taxa fixa', with: '-1'
    click_button 'Salvar'

    expect(page).to have_content 'Não foi possível atualizar a Modalidade de Transporte'
    expect(page).to have_content 'Distância mínima deve ser maior ou igual a 0'
    expect(page).to have_content 'Distância máxima deve ser maior que 0'
    expect(page).to have_content 'Peso máximo deve ser maior que 0'
    expect(page).to have_content 'Peso mínimo deve ser maior ou igual a 0'
    expect(page).to have_content 'Taxa fixa deve ser maior ou igual a 0'
  end

  it 'sem modificar os campos' do
    ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                            minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: 'active')
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: 'admin')
    
    login_as admin  
    visit mode_of_transports_path
    click_link 'Express'
    click_link 'Editar Modalidade de Transporte'
    click_button 'Salvar'
    expect(page).to have_content 'Nenhuma modificação encontrada'
  end
end