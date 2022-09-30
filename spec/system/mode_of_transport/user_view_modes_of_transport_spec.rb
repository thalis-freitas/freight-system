require 'rails_helper'

describe 'Usuário vê modalidades de transporte' do
  it 'a partir do menu' do 
    ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                            minimum_weight: 0, maximum_weight: 200, flat_rate: 15)
    ModeOfTransport.create!(name:'Econômica', minimum_distance: 100, maximum_distance: 4000, 
                            minimum_weight: 20, maximum_weight: 500, flat_rate: 5)

    visit root_path
    within('.menu') do 
      click_link 'Modalidades de Transporte'
    end

    expect(page).to have_content 'Express'
    expect(page).to have_content 'Distância mínima: 20km'
    expect(page).to have_content 'Distância máxima: 2000km'
    expect(page).to have_content 'Peso mínimo: 0kg'
    expect(page).to have_content 'Peso máximo: 200kg'
    expect(page).to have_content 'Taxa fixa: R$15,00'
    expect(page).to have_content 'Econômica'
    expect(page).to have_content 'Distância mínima: 100km'
    expect(page).to have_content 'Distância máxima: 4000km'
    expect(page).to have_content 'Peso mínimo: 20kg'
    expect(page).to have_content 'Peso máximo: 500kg'
    expect(page).to have_content 'Taxa fixa: R$5,00'
  end

  it 'e não existem modalidades de transporte cadastradas' do
    visit mode_of_transports_path

    expect(page).to have_content 'Nenhuma Modalidade de Transporte cadastrada'
  end

  it 'e volta para a página inicial' do
    visit mode_of_transports_path
    click_link 'Sistema de Frete'
    
    expect(current_path).to eq root_path
  end
end