require 'rails_helper'

describe 'Usuário vê veículos' do
  it 'se estiver autenticado' do 
    visit root_path
    expect(page).not_to have_content 'Veículos'
  end

  it 'a partir da url se estiver autenticado' do 
    visit vehicles_path
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'a partir do menu' do 
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                    maximum_capacity: 23000)
    Vehicle.create!(nameplate: 'IOC0693', brand: 'KIA', model: 'BONGO K 2500', year_of_manufacture: '2015', 
                    maximum_capacity: 3400, status: :in_maintenance)
    Vehicle.create!(nameplate: 'KER0414', brand: 'Volks', model: 'Constelallation 17.250', year_of_manufacture: '2012',
                    maximum_capacity: 16000, status: :on_delivery)
    login_as user
    visit root_path
    within('nav') do 
      click_link 'Veículos'
    end

    expect(page).to have_link 'HPK3528'
    expect(page).to have_content 'Marca: Ford'
    expect(page).to have_content 'Modelo: Cargo 2428 E'
    expect(page).to have_content 'Ano de fabricação: 2011'
    expect(page).to have_content 'Capacidade máxima: 23000kg'
    expect(page).to have_link 'IOC0693'
    expect(page).to have_content 'Marca: KIA'
    expect(page).to have_content 'Modelo: BONGO K 2500'
    expect(page).to have_content 'Ano de fabricação: 2015'
    expect(page).to have_content 'Capacidade máxima: 3400kg'
    expect(page).to have_link 'KER0414'
    expect(page).to have_content 'Marca: Volks'
    expect(page).to have_content 'Modelo: Constelallation 17.250'
    expect(page).to have_content 'Ano de fabricação: 2012'
    expect(page).to have_content 'Capacidade máxima: 16000kg'

  end

  it 'e não existem veículos cadastrados' do 
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit vehicles_path
    expect(page).to have_content 'Nenhum veículo em operação'
    expect(page).to have_content 'Nenhum veículo em manutenção'
    expect(page).to have_content 'Nenhum veículo em entrega'
  end  
  
  it 'e volta para a página inicial' do
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user 
    visit vehicles_path
    click_link 'Sistema de Frete'
    expect(current_path).to eq root_path
  end
end