require 'rails_helper'

describe 'Usuário vê as configurações de preço por peso de uma modalidade de transporte' do
  it 'a partir do menu' do 
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    mode_of_transport = ModeOfTransport.create!(name:'Econômica', minimum_distance: 100, maximum_distance: 4000, 
                                                minimum_weight: 20, maximum_weight: 500, flat_rate: 5, status: :active)
    PriceByWeight.create!(minimum_weight: 20, maximum_weight: 150, value: 1, mode_of_transport: mode_of_transport)
    PriceByWeight.create!(minimum_weight: 151, maximum_weight: 320, value: 2, mode_of_transport: mode_of_transport)
    PriceByWeight.create!(minimum_weight: 321, maximum_weight: 500, value: 3, mode_of_transport: mode_of_transport)

    login_as user
    visit root_path
    within('nav') do 
      click_link 'Modalidades de Transporte'
    end
    click_link 'Econômica'

    expect(page).to have_content 'Configuração de preços por peso'
    expect(page).to have_content 'Intervalo'
    expect(page).to have_content 'De 20kg a 150kg'
    expect(page).to have_content 'De 151kg a 320kg'
    expect(page).to have_content 'De 321kg a 500kg'
    expect(page).to have_content 'Valor por km'
    expect(page).to have_content 'R$ 1,00'
    expect(page).to have_content 'R$ 2,00'
    expect(page).to have_content 'R$ 3,00'
  end
end
