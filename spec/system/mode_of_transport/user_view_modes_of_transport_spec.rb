require 'rails_helper'

describe 'Usuário vê modalidades de transporte' do
  it 'a partir do menu' do 
    visit root_path
    within('.menu') do 
      click_on 'Modalidades de Transporte'
    end

    expect(page).to have_content('Express')
    expect(page).to have_content('Econômica')
  end

  it 'e não existem modalidades de transporte cadastradas' do
    ModeOfTransport.destroy_all

    visit modes_of_transport_index_path

    expect(page).to have_content('Nenhuma Modalidade de Transporte cadastrada')
  end

  it 'e volta para a página inicial' do
    visit modes_of_transport_index_path
    click_on 'Sistema de Frete'
    
    expect(current_path).to eq root_path
  end
end