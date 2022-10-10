require 'rails_helper'

describe 'Usuário vê as configurações de preço por distância de uma modalidade de transporte' do
  it 'a partir do menu' do 
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    mode_of_transport = ModeOfTransport.create!(name:'Econômica', minimum_distance: 100, maximum_distance: 4000, 
                                                minimum_weight: 20, maximum_weight: 500, flat_rate: 5, status: :active)
    PricePerDistance.create!(minimum_distance: 100, maximum_distance: 500, rate: 8, mode_of_transport: mode_of_transport)
    PricePerDistance.create!(minimum_distance: 501, maximum_distance: 1000, rate: 15, mode_of_transport: mode_of_transport)
    PricePerDistance.create!(minimum_distance: 1001, maximum_distance: 2000, rate: 22, mode_of_transport: mode_of_transport)
    PricePerDistance.create!(minimum_distance: 2001, maximum_distance: 4000, rate: 30, mode_of_transport: mode_of_transport)

    login_as user
    visit root_path
    within('nav') do 
      click_link 'Modalidades de Transporte'
    end
    click_link 'Econômica'

    expect(page).to have_content 'Configuração de preços por distância'
    expect(page).to have_content 'Intervalo'
    expect(page).to have_content 'De 100km a 500km'
    expect(page).to have_content 'De 501km a 1000km'
    expect(page).to have_content 'De 1001km a 2000km'
    expect(page).to have_content 'De 2001km a 4000km'
    expect(page).to have_content 'Valor por km'
    expect(page).to have_content 'R$ 8,00'
    expect(page).to have_content 'R$ 15,00'
    expect(page).to have_content 'R$ 22,00'
    expect(page).to have_content 'R$ 30,00'
  end
end
