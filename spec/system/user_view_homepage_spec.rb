require 'rails_helper'

describe 'Usuário visita a tela inicial' do
  it 'e vê o nome da aplicação' do 
    visit root_path
    expect(page).to have_link('Sistema de Frete')
  end
end