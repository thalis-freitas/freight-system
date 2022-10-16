require 'rails_helper'

describe 'Usuário não autenticado visita a tela inicial' do
  it 'e vê o nome da aplicação' do 
    visit root_path
    expect(page).to have_link('Sistema de Frete')
  end

   it 'e não vê as ordens de serviço' do 
    visit root_path
    expect(page).not_to have_content 'Ordens de Serviço pendentes'    
    expect(page).not_to have_content 'Ordens de Serviço em andamento'
   end
end