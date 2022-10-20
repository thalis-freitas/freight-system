require 'rails_helper'

describe 'Usuário cadastra uma ordem de serviço' do 
  it 'se estiver autenticado' do 
    visit new_service_order_path
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'se for admin' do 
    user = User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit root_path
    expect(page).not_to have_link 'Cadastrar Ordem de Serviço'
  end

  it 'a partir da url se for admin' do 
    user = User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
    login_as user 
    visit new_service_order_path
    expect(current_path).to eq root_path
    expect(page).to have_content 'Acesso não autorizado'
  end

  it 'a partir da página inicial' do
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)
    
    login_as admin
    visit root_path
    click_link 'Cadastrar Ordem de Serviço'

    expect(page).to have_content 'Cadastrar Ordem de Serviço'
    within('main form') do
      expect(page).to have_field 'Endereço de origem'
      expect(page).to have_field 'Código do produto'
      expect(page).to have_field 'Altura', type: 'number'
      expect(page).to have_field 'Largura', type: 'number'
      expect(page).to have_field 'Profundidade', type: 'number'
      expect(page).to have_field 'Peso', type: 'number'
      expect(page).to have_field 'Endereço destino'
      expect(page).to have_field 'Nome do destinatário'
      expect(page).to have_field 'Telefone', type: 'number'
      expect(page).to have_field 'Distância total', type: 'number'
      expect(page).to have_button 'Salvar'
    end
  end
  
  it 'com sucesso' do
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789DEF')

    login_as admin
    visit new_service_order_path
    fill_in 'Endereço de origem', with: 'Avenida Esbertalina Barbosa Damiani, 85 - São Mateus'
    fill_in 'Código do produto', with: 'AMROS-SmdnT-EPSLD'
    fill_in 'Altura', with: '200'
    fill_in 'Largura', with: '80'
    fill_in 'Profundidade', with: '3'
    fill_in 'Peso', with: '4'
    fill_in 'Endereço destino', with: 'Rua Tenente-Coronel Cardoso, 264 - Campos dos Goytacazes'
    fill_in 'Nome do destinatário', with: 'Flávia Andrade'
    fill_in 'Telefone', with: '22996573849'
    fill_in 'Distância total', with: '480'
    click_button 'Salvar'

    expect(page).to have_content 'Ordem de Serviço ABC123456789DEF'
    expect(page).to have_content 'Endereço de origem: Avenida Esbertalina Barbosa Damiani, 85 - São Mateus'
    expect(page).to have_content 'Código do produto: AMROS-SMDNT-EPSLD'
    expect(page).to have_content 'Dimensões: 200cm x 80cm x 3cm'
    expect(page).to have_content 'Peso: 4kg'
    expect(page).to have_content 'Endereço destino: Rua Tenente-Coronel Cardoso, 264 - Campos dos Goytacazes'
    expect(page).to have_content 'Nome do destinatário: Flávia Andrade'
    expect(page).to have_content 'Telefone: (22)99657-3849'
    expect(page).to have_content 'Distância total: 480km'
    expect(page).to have_content 'Status: Pendente'
  end

  it 'com dados incompletos' do
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)

    login_as admin
    visit new_service_order_path
    fill_in 'Endereço de origem', with: ''
    fill_in 'Código do produto', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Profundidade', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Endereço destino', with: ''
    fill_in 'Nome do destinatário', with: ''
    fill_in 'Telefone', with: ''
    fill_in 'Distância total', with: ''
    click_button 'Salvar'

    expect(page).not_to have_content 'Ordem de Serviço cadastrada com sucesso'
    expect(page).to have_content 'Não foi possível cadastrar a Ordem de Serviço'
    expect(page).to have_content 'Por favor verifique os erros abaixo'
    expect(page).to have_content 'Endereço de origem não pode ficar em branco'
    expect(page).to have_content 'Código do produto não pode ficar em branco'
    expect(page).to have_content 'Altura não pode ficar em branco'
    expect(page).to have_content 'Largura não pode ficar em branco'
    expect(page).to have_content 'Profundidade não pode ficar em branco'
    expect(page).to have_content 'Peso não pode ficar em branco'
    expect(page).to have_content 'Endereço destino não pode ficar em branco'
    expect(page).to have_content 'Nome do destinatário não pode ficar em branco'
    expect(page).to have_content 'Telefone não pode ficar em branco'
    expect(page).to have_content 'Distância total não pode ficar em branco'
  end

  it 'com dados inválidos' do 
    admin = User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)

    login_as admin
    visit new_service_order_path
    fill_in 'Código do produto', with: 'A'
    fill_in 'Altura', with: '-30'
    fill_in 'Largura', with: '-59'
    fill_in 'Profundidade', with: '0'
    fill_in 'Peso', with: '-3'
    fill_in 'Telefone', with: '22'
    fill_in 'Distância total', with: '-304'
    click_button 'Salvar'

    expect(page).to have_content 'Código do produto não possui o tamanho esperado (17 caracteres)'
    expect(page).to have_content 'Altura deve ser maior que 0'
    expect(page).to have_content 'Largura deve ser maior que 0'
    expect(page).to have_content 'Profundidade deve ser maior que 0'
    expect(page).to have_content 'Peso deve ser maior que 0'
    expect(page).to have_content 'Telefone é muito curto (mínimo: 10 caracteres)'
    expect(page).to have_content 'Distância total deve ser maior que 0'
  end
end