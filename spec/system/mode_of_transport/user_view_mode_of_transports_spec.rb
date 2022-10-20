require 'rails_helper'

describe 'Usuário vê modalidades de transporte' do
  it 'se estiver autenticado' do 
    visit root_path
    expect(page).not_to have_content 'Modalidades de Transporte'
  end

  it 'a partir da url se estiver autenticado' do 
    visit mode_of_transports_path
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'a partir do menu' do 
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')

    ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                            minimum_weight: 0, maximum_weight: 200, flat_rate: 1500, status: :active)
    ModeOfTransport.create!(name:'Econômica', minimum_distance: 100, maximum_distance: 4000, 
                            minimum_weight: 20, maximum_weight: 500, flat_rate: 500, status: :active)
    login_as user
    visit root_path
    within('nav') do 
      click_link 'Modalidades de Transporte'
    end

    expect(page).to have_content 'Express'
    expect(page).to have_content 'Distância mínima: 20km'
    expect(page).to have_content 'Distância máxima: 2000km'
    expect(page).to have_content 'Peso mínimo: 0kg'
    expect(page).to have_content 'Peso máximo: 200kg'
    expect(page).to have_content 'Taxa fixa: R$ 15,00'
    expect(page).to have_content 'Econômica'
    expect(page).to have_content 'Distância mínima: 100km'
    expect(page).to have_content 'Distância máxima: 4000km'
    expect(page).to have_content 'Peso mínimo: 20kg'
    expect(page).to have_content 'Peso máximo: 500kg'
    expect(page).to have_content 'Taxa fixa: R$ 5,00'
  end

  it 'inativas se for admin' do
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                            minimum_weight: 0, maximum_weight: 500, flat_rate: 1500, status: :inactive)
    login_as user  
    visit mode_of_transports_path

    expect(page).not_to have_content 'Modalidades de Transporte Inativas'
    expect(page).not_to have_link 'Express'
  end

  it 'inativas' do 
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, minimum_weight: 0,
                            maximum_weight: 500, flat_rate: 1500, status: :inactive)
    ModeOfTransport.create!(name:'Rota 10', minimum_distance: 50, maximum_distance: 1200, minimum_weight: 0,
                            maximum_weight: 2900, flat_rate: 500, status: :inactive) 
    login_as admin   
    visit mode_of_transports_path

    expect(page).to have_content 'Modalidades de Transporte Inativas'
    expect(page).to have_link 'Express'
    expect(page).to have_content 'Taxa fixa: R$ 15,00'
    expect(page).to have_link 'Rota 10'
    expect(page).to have_content 'Taxa fixa: R$ 5,00'
  end

  it 'e não existem modalidades de transporte cadastradas' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    login_as admin
    visit mode_of_transports_path
    expect(page).to have_content 'Nenhuma modalidade de transporte ativa'
    expect(page).to have_content 'Nenhuma modalidade de transporte inativa'
  end

  it 'e volta para a página inicial' do
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user 
    visit mode_of_transports_path
    click_link 'Sistema de Frete'
    expect(current_path).to eq root_path
  end
end