require 'rails_helper'

describe 'Usuário cadastra modalidade de transporte' do
  it 'a partir do menu' do
    visit root_path
    within('.menu') do 
      click_link 'Modalidades de Transporte'
    end
    click_link 'Cadastrar Modalidade de Transporte'

    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Distância mínima', type: 'number'
    expect(page).to have_field 'Distância máxima', type: 'number'
    expect(page).to have_field 'Peso mínimo', type: 'number'
    expect(page).to have_field 'Peso máximo', type: 'number'
    expect(page).to have_field 'Taxa fixa', type: 'number'
    expect(page).to have_button 'Salvar'
  end
  
  it 'com sucesso' do
    visit new_mode_of_transport_path
    fill_in 'Nome', with: 'Express'
    fill_in 'Distância mínima', with: '20'
    fill_in 'Distância máxima', with: '2000'
    fill_in 'Peso mínimo', with: '0'
    fill_in 'Peso máximo', with: '30000'
    fill_in 'Taxa fixa', with: '15'
    click_button 'Salvar'

    expect(page).to have_content 'Modalidade de Transporte cadastrada com sucesso'
    expect(page).to have_content 'Express'
    expect(page).to have_content 'Distância mínima: 20km'
    expect(page).to have_content 'Distância máxima: 2000km'
    expect(page).to have_content 'Peso mínimo: 0kg'
    expect(page).to have_content 'Peso máximo: 30000kg'
    expect(page).to have_content 'Taxa fixa: R$15,00'
  end

  it 'com dados incompletos' do 
    visit new_mode_of_transport_path
    fill_in 'Nome', with: ''
    fill_in 'Distância mínima', with: ''
    fill_in 'Peso mínimo', with: ''
    click_button 'Salvar'

    expect(page).to_not have_content 'Modalidade de Transporte cadastrada com sucesso'
    expect(page).to have_content 'Não foi possível cadastrar a Modalidade de Transporte'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Distância mínima não pode ficar em branco'
    expect(page).to have_content 'Distância máxima não pode ficar em branco'
    expect(page).to have_content 'Peso mínimo não pode ficar em branco'
    expect(page).to have_content 'Peso máximo não pode ficar em branco'
    expect(page).to have_content 'Taxa fixa não pode ficar em branco'
    
  end
end
