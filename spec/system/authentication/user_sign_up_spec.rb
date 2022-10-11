require 'rails_helper'

describe 'Usuário cria uma conta' do
  it 'com sucesso' do
    visit root_path
    click_link 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Marcus Lima'
    fill_in 'E-mail', with: 'marcus_lima@sistemadefrete.com.br'
    fill_in 'Senha', with: 'pass1234'
    fill_in 'Confirme sua senha', with: 'pass1234'
    click_on 'Salvar'
    
    expect(page).to have_content 'Marcus Lima'
    expect(page).to have_button 'Sair'
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    user = User.last
    expect(user.name).to eq 'Marcus Lima'
  end

  it 'com email que já está em uso' do
    User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')

    visit new_user_session_path
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Ellen Machado'
    fill_in 'E-mail', with: 'daiane_silva@sistemadefrete.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Salvar'
    
    expect(page).to have_content 'Não foi possível salvar usuário'
    expect(page).to have_content 'E-mail já está em uso'
    expect(page).not_to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
  end

  it 'com senha muito curta' do
    visit new_user_session_path
    click_on 'Criar uma conta'
    fill_in 'Senha', with: 'pass'
    fill_in 'Confirme sua senha', with: 'pass'
    click_on 'Salvar'
    
    expect(page).to have_content 'Senha é muito curto (mínimo: 6 caracteres)'
  end

  it 'e deixa campos em branco' do 
    visit new_user_session_path
    click_on 'Criar uma conta'
    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Salvar'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
  end

  it 'e o domínio do email deve ser @sistemadefrete.com.br' do 
    visit new_user_session_path
    click_on 'Criar uma conta'
    fill_in 'E-mail', with: 'daiane_silva@email.com.br'
    click_on 'Salvar'
    
    expect(page).to have_content 'E-mail inválido'
  end
end