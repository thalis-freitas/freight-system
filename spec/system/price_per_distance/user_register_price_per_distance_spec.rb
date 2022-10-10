require 'rails_helper'

describe 'Usuário cadastra configuração de preço por distância para uma modalidade de transporte' do
  it 'se estiver autenticado' do 
    visit new_price_per_distance_path
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'se for admin' do 
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 15, status: :active)
    user = User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit mode_of_transport_path(mode_of_transport)
    expect(page).not_to have_link 'Cadastrar configuração de preço por distância'
  end

  it 'a partir da da url se for admin' do 
    user = User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
    login_as user 
    visit new_price_per_distance_path
    expect(current_path).to eq root_path
    expect(page).to have_content 'Acesso não autorizado'
  end

  it 'a partir do menu' do
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 15, status: :active)
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)
    
    login_as admin
    visit root_path
    within('nav') do 
      click_link 'Modalidades de Transporte'
    end
    click_link 'Express'
    click_link 'Cadastrar configuração de preço por distância'

    expect(current_path).to eq new_price_per_distance_path
    expect(page).to have_content 'Cadastrar configuração de preço por distância'
    within('.form') do 
      expect(page).to have_field 'Modalidade de transporte', type: 'select'
      expect(page).to have_field 'Distância mínima', type: 'number'
      expect(page).to have_field 'Distância máxima', type: 'number'
      expect(page).to have_field 'Taxa', type: 'number'
      expect(page).to have_button 'Salvar'
    end
  end
  
  it 'com sucesso' do
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 15, status: :active)
    mode_of_transport_2 = ModeOfTransport.create!(name:'Econômica', minimum_distance: 100, maximum_distance: 4000, 
                                                  minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)

    login_as admin
    visit new_price_per_distance_path
    fill_in 'Distância mínima', with: '20'
    fill_in 'Distância máxima', with: '80'
    fill_in 'Taxa', with: '10'
    select 'Express', from: 'Modalidade de transporte'
    click_button 'Salvar'

    expect(page).to have_content 'Configuração de preço por distância cadastrada com sucesso para a modalidade Express'
    expect(current_path).to eq mode_of_transport_path(mode_of_transport)
    expect(page).to have_content 'Intervalo'
    expect(page).to have_content 'De 20km a 80km'
    expect(page).to have_content 'Taxa'
    expect(page).to have_content 'R$ 10,00'
  end

  it 'com dados incompletos' do
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 15, status: :active)
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)

    login_as admin
    visit new_price_per_distance_path
    fill_in 'Distância mínima', with: ''
    fill_in 'Distância máxima', with: ''
    fill_in 'Taxa', with: ''
    click_button 'Salvar'

    expect(page).not_to have_content 'Configuração de preço por distância cadastrada com sucesso para a modalidade Express'
    expect(page).to have_content 'Não foi possível cadastrar a configuração de preço por distância'
    expect(page).to have_content 'Distância mínima não pode ficar em branco'
    expect(page).to have_content 'Distância máxima não pode ficar em branco'
    expect(page).to have_content 'Taxa não pode ficar em branco'
  end

  it 'com dados inválidos' do 
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 15, status: :active)
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)
    
    login_as admin
    visit new_price_per_distance_path
    select 'Express', from: 'Modalidade de transporte'
    fill_in 'Distância mínima', with: '2300'
    fill_in 'Distância máxima', with: '10'
    fill_in 'Taxa', with: '-5'
    click_button 'Salvar'

    expect(page).to have_content 'Não foi possível cadastrar a configuração de preço por distância'
    expect(page).to have_content 'Distância máxima deve ser maior que 20'
    expect(page).to have_content 'Distância mínima deve ser menor que 2000'
    expect(page).to have_content 'Taxa deve ser maior ou igual a 0'
  end

  it 'com distâncias não atendidas pela modalidade de transporte' do 
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 15, status: :active)
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)
    
    login_as admin
    visit new_price_per_distance_path
    select 'Express', from: 'Modalidade de transporte'
    fill_in 'Distância mínima', with: '0'
    fill_in 'Distância máxima', with: '3000'
    click_button 'Salvar'

    expect(page).to have_content 'Não foi possível cadastrar a configuração de preço por distância'
    expect(page).to have_content 'Distância máxima deve ser menor ou igual a 2000'
    expect(page).to have_content 'Distância mínima deve ser maior ou igual a 20'
  end
end
