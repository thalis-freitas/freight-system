require 'rails_helper'

describe 'Usuário edita uma configuração de preço por peso de uma modalidade de transporte' do 
  it 'se estiver autenticado' do 
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: :active)
    price_by_weight = PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 1, 
                                            mode_of_transport: mode_of_transport) 
    visit edit_price_by_weight_path(price_by_weight)
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'se for admin' do 
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: :active)
    price_by_weight = PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 1, 
                                            mode_of_transport: mode_of_transport) 
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit edit_price_by_weight_path(price_by_weight)
    expect(page).not_to have_link 'Editar'
  end

  it 'a partir da da url se for admin' do 
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: :active)
    price_by_weight = PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 1, 
                                            mode_of_transport: mode_of_transport) 
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit edit_price_by_weight_path(price_by_weight)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Acesso não autorizado'
  end

  it 'a partir do menu' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: :active)
    price_by_weight = PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 1, 
                                            mode_of_transport: mode_of_transport)                                            
    
    login_as admin                         
    visit root_path
    within('nav') do 
      click_link 'Modalidades de Transporte'
    end
    click_link 'Express'
    click_link 'Editar'

    expect(current_path).to eq edit_price_by_weight_path(price_by_weight)
    expect(page).to have_content 'Editar configuração de preço por peso modalidade Express'
    within('.form') do 
      expect(page).to have_field 'Peso mínimo', with: '0'
      expect(page).to have_field 'Peso máximo', with: '50'
      expect(page).to have_field 'Valor por km', with: '1'
      expect(page).to have_button 'Salvar'
    end
  end

  it 'com sucesso' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: :active)
    price_by_weight = PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 1, 
                                            mode_of_transport: mode_of_transport)      

    login_as admin  
    visit edit_price_by_weight_path(price_by_weight)
    fill_in 'Peso mínimo', with: '20'
    fill_in 'Peso máximo', with: '70'
    fill_in 'Valor por km', with: '2'
    click_button 'Salvar'

    expect(page).to have_content 'Configuração de preço por peso atualizada com sucesso'
    expect(page).to have_content 'De 20kg a 70kg'
    expect(page).to have_content 'R$ 2,00'
  end

  it 'e deixa campos obrigatórios em branco' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: :active)
    price_by_weight = PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 1, 
                                            mode_of_transport: mode_of_transport)   

    login_as admin  
    visit edit_price_by_weight_path(price_by_weight)
    fill_in 'Peso mínimo', with: ''
    fill_in 'Peso máximo', with: ''
    fill_in 'Valor por km', with: ''
    click_button 'Salvar'

    expect(page).to have_content 'Não foi possível atualizar a configuração de preço por peso'
    expect(page).to have_content 'Peso mínimo não pode ficar em branco'
    expect(page).to have_content 'Peso máximo não pode ficar em branco'
    expect(page).to have_content 'Valor por km não pode ficar em branco'
    expect(page).not_to have_content 'Configuração de preço por peso atualizada com sucesso'
  end

  it 'com dados inválidos' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: :active)
    price_by_weight = PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 1, 
                                            mode_of_transport: mode_of_transport)   

    login_as admin  
    visit edit_price_by_weight_path(price_by_weight)
    fill_in 'Peso mínimo', with: '-10'
    fill_in 'Peso máximo', with: '-8'
    fill_in 'Valor por km', with: '-20'
    click_button 'Salvar'

    expect(page).to have_content 'Não foi possível atualizar a configuração de preço por peso'
    expect(page).to have_content 'Peso mínimo deve ser maior ou igual a 0'
    expect(page).to have_content 'Peso máximo deve ser maior que 0'
    expect(page).to have_content 'Valor por km deve ser maior ou igual a 0'
    expect(page).not_to have_content 'Configuração de preço por peso atualizada com sucesso'
  end

  it 'sem modificar os campos' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    mode_of_transport = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                                minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: :active)
    price_by_weight = PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 1, 
                                            mode_of_transport: mode_of_transport)   

    login_as admin  
    visit edit_price_by_weight_path(price_by_weight)
    click_button 'Salvar'

    expect(page).to have_content 'Nenhuma modificação encontrada'
  end
end