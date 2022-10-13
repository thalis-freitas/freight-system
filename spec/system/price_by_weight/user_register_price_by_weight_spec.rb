require 'rails_helper'

describe 'Usuário cadastra configuração de preço por peso para uma modalidade de transporte' do
  it 'se estiver autenticado' do 
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 1500, status: :active)
    visit new_mode_of_transport_price_by_weight_path(mode_of_transport)
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'se for admin' do 
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 1500, status: :active)
    user = User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit mode_of_transport_path(mode_of_transport)
    expect(page).not_to have_link 'Cadastrar configuração de preço por peso'
  end

  it 'a partir da da url se for admin' do 
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 1500, status: :active)
    user = User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
    login_as user 
    visit new_mode_of_transport_price_by_weight_path(mode_of_transport)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Acesso não autorizado'
  end

  it 'a partir do menu' do
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 1500, status: :active)
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)
    
    login_as admin
    visit root_path
    within('nav') do 
      click_link 'Modalidades de Transporte'
    end
    click_link 'Express'
    click_link 'Cadastrar configuração de preço por peso'

    expect(current_path).to eq new_mode_of_transport_price_by_weight_path(mode_of_transport)
    expect(page).to have_content 'Cadastrar configuração de preço por peso'
    expect(page).to have_content 'Modalidade Express'
    within('.form') do 
      expect(page).to have_field 'Peso mínimo', type: 'number'
      expect(page).to have_field 'Peso máximo', type: 'number'
      expect(page).to have_field 'Valor por km (em centavos)', type: 'number'
      expect(page).to have_button 'Salvar'
    end
  end
  
  it 'com sucesso' do
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 1500, status: :active)
    mode_of_transport_2 = ModeOfTransport.create!(name:'Econômica', minimum_distance: 100, maximum_distance: 4000, 
                                                  minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)

    login_as admin
    visit new_mode_of_transport_price_by_weight_path(mode_of_transport)
    fill_in 'Peso mínimo', with: '0'
    fill_in 'Peso máximo', with: '50'
    fill_in 'Valor por km (em centavos)', with: '50'
    click_button 'Salvar'

    expect(page).to have_content 'Configuração de preço por peso cadastrada com sucesso'
    expect(current_path).to eq mode_of_transport_path(mode_of_transport)
    expect(page).to have_content 'De 0kg a 50kg R$ 0,50'
  end

  it 'com dados incompletos' do
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 1500, status: :active)
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)

    login_as admin
    visit new_mode_of_transport_price_by_weight_path(mode_of_transport)
    fill_in 'Peso mínimo', with: ''
    fill_in 'Peso máximo', with: ''
    fill_in 'Valor por km (em centavos)', with: ''
    click_button 'Salvar'

    expect(page).to_not have_content 'Configuração de preço por peso cadastrada com sucesso'
    expect(page).to have_content 'Não foi possível cadastrar a configuração de preço por peso'
    expect(page).to have_content 'Por favor verifique os erros abaixo'
    expect(page).to have_content 'Peso mínimo não pode ficar em branco'
    expect(page).to have_content 'Peso máximo não pode ficar em branco'
    expect(page).to have_content 'Valor por km não pode ficar em branco'
  end

  it 'com dados inválidos' do 
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 1500, status: :active)
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)
    
    login_as admin
    visit new_mode_of_transport_price_by_weight_path(mode_of_transport)
    fill_in 'Peso mínimo', with: '300'
    fill_in 'Peso máximo', with: '0'
    fill_in 'Valor por km (em centavos)', with: '-10'
    click_button 'Salvar'

    expect(page).to have_content 'Peso máximo deve ser maior que 0'
    expect(page).to have_content 'Peso mínimo deve ser menor que 200'
    expect(page).to have_content 'Valor por km deve ser maior ou igual a 0'
  end

  it 'com pesos não atendidos pela modalidade de transporte' do 
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 10, maximum_weight: 200, flat_rate: 1500, status: :active)
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)
    
    login_as admin
    visit new_mode_of_transport_price_by_weight_path(mode_of_transport)
    fill_in 'Peso mínimo', with: '5'
    fill_in 'Peso máximo', with: '250'
    fill_in 'Valor por km (em centavos)', with: '-10'
    click_button 'Salvar'

    expect(page).to have_content 'Peso mínimo deve ser maior ou igual a 10'
    expect(page).to have_content 'Peso máximo deve ser menor ou igual a 200'
    expect(page).to have_content 'Valor por km deve ser maior ou igual a 0'
  end
end
