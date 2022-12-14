require 'rails_helper'

describe 'Usuário busca por um veículo' do
  it 'se estiver autenticado' do
    visit vehicles_path
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'a partir do menu' do
    Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                    maximum_capacity: 23_000)
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Veículos'
    end
    within('main') do
      expect(page).to have_button 'Buscar Veículo'
    end
  end

  it 'e encontra o veículo' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                    maximum_capacity: 23_000)

    login_as admin
    visit vehicles_path
    within('main') do
      fill_in 'query', with: 'HPK3528'
      click_on 'Buscar'
    end

    expect(page).to have_content 'Resultados da busca por HPK3528'
    expect(page).to have_content '1 veículo encontrado'
    expect(page).to have_link 'HPK3528'
    expect(page).to have_content 'Capacidade máxima: 23000kg'
    expect(page).to have_content 'Status: Em operação'
  end

  it 'e encontra múltiplos veículos' do
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password',
                         role: :admin)
    Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                    maximum_capacity: 23_000)
    Vehicle.create!(nameplate: 'HPK0693', brand: 'KIA', model: 'BONGO K 2500', year_of_manufacture: '2015',
                    maximum_capacity: 3400, status: :in_maintenance)
    Vehicle.create!(nameplate: 'ZZZ0000', brand: 'Volks', model: 'Constelallation 17.250', year_of_manufacture: '2012',
                    maximum_capacity: 16_000)

    login_as admin
    visit vehicles_path
    within('main') do
      fill_in 'query', with: 'hpk'
      click_on 'Buscar'
    end

    expect(page).to have_content '2 veículos encontrados'
    expect(page).to have_link 'HPK3528'
    expect(page).to have_link 'HPK0693'
    expect(page).to have_content 'Capacidade máxima: 3400kg'
    expect(page).not_to have_link 'ZZZ0000'
    expect(page).not_to have_content 'Capacidade máxima: 16000kg'
  end

  it 'e não encontra nenhum veículo' do
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password',
                         role: :admin)
    login_as admin
    visit vehicles_path
    within('main') do
      fill_in 'query', with: 'hpk'
      click_on 'Buscar'
    end
    expect(page).to have_content 'Nenhum veículo encontrado'
  end

  it 'sem preencher o campo' do
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password',
                         role: :admin)
    login_as admin
    visit vehicles_path
    within('main') do
      fill_in 'query', with: ''
      click_on 'Buscar'
    end
    expect(page).to have_content 'É necessário preencher o campo para fazer a busca'
    expect(page).not_to have_content 'Resultados da busca por'
  end
end
