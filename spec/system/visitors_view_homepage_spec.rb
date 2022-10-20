require 'rails_helper'

describe 'Usuário não autenticado visita a tela inicial' do
  it 'e vê o nome da aplicação' do 
    visit root_path
    expect(page).to have_link 'Sistema de Frete'
    expect(page).to have_content 'Boas vindas ao sistema de frete! Para consultar o status do seu pedido preencha o campo abaixo com o código de rastreio'
  end

   it 'e não vê as ordens de serviço' do 
    visit root_path
    expect(page).not_to have_content 'Ordens de Serviço pendentes'    
    expect(page).not_to have_content 'Ordens de Serviço em andamento'
    expect(page).not_to have_link 'Ordens de Serviço encerradas'
   end
end