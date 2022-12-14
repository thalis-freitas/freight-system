require 'rails_helper'

describe 'Usuário atualiza status da modalidade de transporte' do
  it 'se for admin' do
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20, maximum_distance: 2000,
                                                minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: :active)
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit mode_of_transport_path(mode_of_transport)
    expect(page).not_to have_button 'Desativar'
  end

  it 'a partir do menu' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    ModeOfTransport.create!(name: 'Express', minimum_distance: 20, maximum_distance: 2000,
                            minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: :active)

    login_as admin
    visit root_path
    click_link 'Modalidades de Transporte'
    click_link 'Express'
    expect(page).to have_button 'Desativar'
  end

  it 'para inativa com sucesso' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20, maximum_distance: 2000,
                                                minimum_weight: 0, maximum_weight: 500, flat_rate: 15, status: :active)

    login_as admin
    visit mode_of_transport_path(mode_of_transport)
    click_button 'Desativar'

    expect(page).to have_content 'Modalidade de Transporte desativada com sucesso'
    expect(page).not_to have_button 'Desativar'
    expect(page).to have_button 'Ativar'
  end

  it 'para ativa com sucesso' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    mode_of_transport = ModeOfTransport.create!(name: 'Rapidex', minimum_distance: 0, maximum_distance: 1000,
                                                minimum_weight: 0, maximum_weight: 150, flat_rate: 13,
                                                status: :inactive)

    login_as admin
    visit mode_of_transport_path(mode_of_transport)
    click_button 'Ativar'

    expect(page).to have_content 'Modalidade de Transporte ativada com sucesso'
    expect(page).not_to have_button 'Ativar'
    expect(page).to have_button 'Desativar'
  end
end
