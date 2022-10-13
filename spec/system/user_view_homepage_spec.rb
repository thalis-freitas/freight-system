require 'rails_helper'

describe 'Usuário visita a tela inicial' do
  it 'e vê o nome da aplicação' do 
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit root_path
    expect(page).to have_link('Sistema de Frete')
  end
end