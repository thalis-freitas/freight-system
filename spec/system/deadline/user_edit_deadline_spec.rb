require 'rails_helper'

describe 'Usuário edita uma configuração de prazo de uma modalidade de transporte' do
  it 'se estiver autenticado' do
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20,
                                                maximum_distance: 2000, minimum_weight: 0,
                                                maximum_weight: 500, flat_rate: 1500,
                                                status: :active)
    deadline = Deadline.create!(minimum_distance: 20, maximum_distance: 100, estimated_time: 3,
                                mode_of_transport:)
    visit edit_mode_of_transport_deadline_path(mode_of_transport, deadline)
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'se for admin' do
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20,
                                                maximum_distance: 2000, minimum_weight: 0,
                                                maximum_weight: 500, flat_rate: 1500,
                                                status: :active)
    Deadline.create!(minimum_distance: 20, maximum_distance: 100, estimated_time: 3,
                     mode_of_transport:)
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit mode_of_transport_path(mode_of_transport)
    expect(page).not_to have_link 'Editar'
  end

  it 'a partir da url se for admin' do
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20,
                                                maximum_distance: 2000, minimum_weight: 0,
                                                maximum_weight: 500, flat_rate: 1500,
                                                status: :active)
    deadline = Deadline.create!(minimum_distance: 20, maximum_distance: 100, estimated_time: 3,
                                mode_of_transport:)
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit edit_mode_of_transport_deadline_path(mode_of_transport, deadline)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Acesso não autorizado'
  end

  it 'a partir do menu' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20,
                                                maximum_distance: 2000, minimum_weight: 0,
                                                maximum_weight: 500, flat_rate: 1500,
                                                status: :active)
    deadline = Deadline.create!(minimum_distance: 20, maximum_distance: 100, estimated_time: 3,
                                mode_of_transport:)

    login_as admin
    visit root_path
    within('nav') do
      click_link 'Modalidades de Transporte'
    end
    click_link 'Express'
    click_link 'Editar'

    expect(current_path).to eq edit_mode_of_transport_deadline_path(mode_of_transport, deadline)
    expect(page).to have_content 'Editar configuração de prazo'
    expect(page).to have_content 'Modalidade Express'
    within('main form') do
      expect(page).to have_field 'Distância mínima', with: '20'
      expect(page).to have_field 'Distância máxima', with: '100'
      expect(page).to have_field 'Prazo em horas', with: '3'
      expect(page).to have_button 'Salvar'
    end
  end

  it 'com sucesso' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20,
                                                maximum_distance: 2000, minimum_weight: 0,
                                                maximum_weight: 500, flat_rate: 1500,
                                                status: :active)
    deadline = Deadline.create!(minimum_distance: 25, maximum_distance: 105, estimated_time: 3,
                                mode_of_transport:)

    login_as admin
    visit edit_mode_of_transport_deadline_path(mode_of_transport, deadline)
    fill_in 'Distância mínima', with: '20'
    fill_in 'Distância máxima', with: '100'
    fill_in 'Prazo em horas', with: '2'
    click_button 'Salvar'

    expect(page).to have_content 'Configuração de prazo atualizada com sucesso'
    expect(page).to have_content 'Express'
    expect(page).to have_content 'De 20km a 100km 2 horas'
  end

  it 'e deixa campos obrigatórios em branco' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20,
                                                maximum_distance: 2000, minimum_weight: 0,
                                                maximum_weight: 500, flat_rate: 1500,
                                                status: :active)
    deadline = Deadline.create!(minimum_distance: 25, maximum_distance: 105, estimated_time: 3,
                                mode_of_transport:)

    login_as admin
    visit edit_mode_of_transport_deadline_path(mode_of_transport, deadline)
    fill_in 'Distância mínima', with: ''
    fill_in 'Distância máxima', with: ''
    fill_in 'Prazo em horas', with: ''
    click_button 'Salvar'

    expect(page).to have_content 'Não foi possível atualizar a configuração de prazo'
    expect(page).to have_content 'Distância mínima não pode ficar em branco'
    expect(page).to have_content 'Distância máxima não pode ficar em branco'
    expect(page).to have_content 'Prazo não pode ficar em branco'
    expect(page).not_to have_content 'Configuração de prazo atualizada com sucesso'
  end

  it 'com dados inválidos' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20,
                                                maximum_distance: 2000, minimum_weight: 0,
                                                maximum_weight: 500, flat_rate: 1500,
                                                status: :active)
    deadline = Deadline.create!(minimum_distance: 25, maximum_distance: 105, estimated_time: 3,
                                mode_of_transport:)

    login_as admin
    visit edit_mode_of_transport_deadline_path(mode_of_transport, deadline)
    fill_in 'Distância mínima', with: '2500'
    fill_in 'Distância máxima', with: '5'
    fill_in 'Prazo', with: '-8'
    click_button 'Salvar'

    expect(page).to have_content 'Distância mínima deve ser menor que 2000'
    expect(page).to have_content 'Distância máxima deve ser maior que 20'
    expect(page).to have_content 'Prazo deve ser maior que 0'
  end

  it 'com distâncias não atendidas pela modalidade de transporte' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20,
                                                maximum_distance: 2000, minimum_weight: 0,
                                                maximum_weight: 500, flat_rate: 1500,
                                                status: :active)
    deadline = Deadline.create!(minimum_distance: 25, maximum_distance: 105, estimated_time: 3,
                                mode_of_transport:)

    login_as admin
    visit edit_mode_of_transport_deadline_path(mode_of_transport, deadline)
    fill_in 'Distância mínima', with: '15'
    fill_in 'Distância máxima', with: '4000'
    click_button 'Salvar'

    expect(page).to have_content 'Distância mínima deve ser maior ou igual a 20'
    expect(page).to have_content 'Distância máxima deve ser menor ou igual a 2000'
  end

  it 'sem modificar os campos' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20,
                                                maximum_distance: 2000, minimum_weight: 0,
                                                maximum_weight: 500, flat_rate: 1500,
                                                status: :active)
    deadline = Deadline.create!(minimum_distance: 25, maximum_distance: 105, estimated_time: 3,
                                mode_of_transport:)
    login_as admin
    visit edit_mode_of_transport_deadline_path(mode_of_transport, deadline)
    click_button 'Salvar'

    expect(page).to have_content 'Nenhuma modificação encontrada'
  end
end
