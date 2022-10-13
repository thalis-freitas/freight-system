require 'rails_helper'

describe 'Usuário vê as configurações de prazo de uma modalidade de transporte' do
  it 'a partir do menu' do 
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    mode_of_transport = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                                minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)    
    Deadline.create!(minimum_distance: 500, maximum_distance: 1000, estimated_time: 120, mode_of_transport: mode_of_transport)
    Deadline.create!(minimum_distance: 1001, maximum_distance: 2000, estimated_time: 336, mode_of_transport: mode_of_transport)
    Deadline.create!(minimum_distance: 2001, maximum_distance: 3000, estimated_time: 504, mode_of_transport: mode_of_transport)
    Deadline.create!(minimum_distance: 3001, maximum_distance: 4000, estimated_time: 672, mode_of_transport: mode_of_transport)

    login_as user
    visit root_path
    within('nav') do 
      click_link 'Modalidades de Transporte'
    end
    click_link 'Econômica'

    expect(page).to have_content 'Configuração de prazos'
    expect(page).to have_content 'Distância'
    expect(page).to have_content 'Prazo'
    expect(page).to have_content 'De 500km a 1000km 120 horas'
    expect(page).to have_content 'De 1001km a 2000km 14 dias'
    expect(page).to have_content 'De 2001km a 3000km 21 dias'
    expect(page).to have_content 'De 3001km a 4000km 28 dias'
  end
end
