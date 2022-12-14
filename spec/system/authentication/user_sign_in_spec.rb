require 'rails_helper'

describe 'Usuário faz autenticação' do
  it 'a partir da página inicial' do
    visit root_path
    within('nav') do
      click_link 'Entrar'
    end
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')

    visit new_user_session_path
    within('form') do
      fill_in 'E-mail', with: 'daiane_silva@sistemadefrete.com.br'
      fill_in 'Senha', with: 'senha123'
      click_button 'Entrar'
    end

    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Daiane Silva'
    end
    expect(page).to have_content 'Login efetuado com sucesso'
  end

  it 'e faz logout' do
    User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')

    visit new_user_session_path
    fill_in 'E-mail', with: 'daiane_silva@sistemadefrete.com.br'
    fill_in 'Senha', with: 'senha123'
    within('form') do
      click_on 'Entrar'
    end
    click_button 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_content 'Daiane Silva'
    expect(page).not_to have_button 'Sair'
  end

  it 'com dados inválidos' do
    visit new_user_session_path
    within('form') do
      fill_in 'E-mail', with: ''
      click_on 'Entrar'
    end

    expect(page).to have_content 'E-mail ou senha inválidos'
  end
end
