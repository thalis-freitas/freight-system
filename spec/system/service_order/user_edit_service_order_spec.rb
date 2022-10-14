require 'rails_helper'

describe 'Usuário edita uma ordem de serviço' do 
  it 'se estiver autenticado' do 
    service_order = ServiceOrder.create!(source_address: 'Rua Paracatu, 957 - São Paulo', product_code: 'AMDNF-EOLDF-SHNFK',
                                         height: 70, width: 40, depth: 30, weight: 2, destination_address: 'Rua da Imprensa, 48 - Gramado',
                                         recipient: 'João Cerqueira', recipient_phone: '54988475495', total_distance: 1120)
    visit edit_service_order_path(service_order)
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'se for admin' do 
    service_order = ServiceOrder.create!(source_address: 'Rua Paracatu, 957 - São Paulo', product_code: 'AMDNF-EOLDF-SHNFK',
                                         height: 70, width: 40, depth: 30, weight: 2, destination_address: 'Rua da Imprensa, 48 - Gramado',
                                         recipient: 'João Cerqueira', recipient_phone: '54988475495', total_distance: 1120)
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit service_order_path(service_order)
    expect(page).not_to have_link 'Editar Ordem de Serviço'
  end

  it 'a partir da da url se for admin' do 
    service_order = ServiceOrder.create!(source_address: 'Rua Paracatu, 957 - São Paulo', product_code: 'AMDNF-EOLDF-SHNFK',
                                         height: 70, width: 40, depth: 30, weight: 2, destination_address: 'Rua da Imprensa, 48 - Gramado',
                                         recipient: 'João Cerqueira', recipient_phone: '54988475495', total_distance: 1120)
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit edit_service_order_path(service_order)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Acesso não autorizado'
  end

  it 'a partir da página inicial' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789DEF')
    ServiceOrder.create!(source_address: 'Rua Paracatu, 957 - São Paulo', product_code: 'AMDNF-EOLDF-SHNFK',
                         height: 70, width: 40, depth: 30, weight: 2, destination_address: 'Rua da Imprensa, 48 - Gramado',
                         recipient: 'João Cerqueira', recipient_phone: '54988475495', total_distance: 1120)
    
    login_as admin                         
    visit root_path
    click_link 'ABC123456789DEF'
    click_link 'Editar Ordem de Serviço'

    within('main form') do
      expect(page).to have_field 'Endereço de origem', with: 'Rua Paracatu, 957 - São Paulo'
      expect(page).to have_field 'Código do produto', with: 'AMDNF-EOLDF-SHNFK'
      expect(page).to have_field 'Altura', type: 'number', with: '70'
      expect(page).to have_field 'Largura', type: 'number', with: '40'
      expect(page).to have_field 'Profundidade', type: 'number', with: '30'
      expect(page).to have_field 'Peso', type: 'number', with: '2'
      expect(page).to have_field 'Endereço destino', with: 'Rua da Imprensa, 48 - Gramado'
      expect(page).to have_field 'Nome do destinatário', with: 'João Cerqueira'
      expect(page).to have_field 'Telefone', type: 'number', with: '54988475495'
      expect(page).to have_field 'Distância total', type: 'number', with: '1120'
      expect(page).to have_button 'Salvar'
    end
  end

  it 'com sucesso' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    service_order = ServiceOrder.create!(source_address: 'Rua Paracatu, 957 - São Paulo', product_code: 'AMDNF-EOLDF-SHNFK',
                                         height: 70, width: 40, depth: 30, weight: 2, destination_address: 'Rua da Imprensa, 48 - Gramado',
                                         recipient: 'João Cerqueira', recipient_phone: '54988475495', total_distance: 1120)
    login_as admin  
    visit edit_service_order_path(service_order)
    fill_in 'Telefone', with: '5433489283'
    click_button 'Salvar'

    expect(page).to have_content 'Ordem de Serviço atualizada com sucesso'
    expect(page).to have_content 'Telefone: (54)3348-9283'
    expect(page).not_to have_content 'Telefone: (54)98847-5495'
  end

  it 'e deixa campos obrigatórios em branco' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    service_order = ServiceOrder.create!(source_address: 'Rua Paracatu, 957 - São Paulo', product_code: 'AMDNF-EOLDF-SHNFK',
                                         height: 70, width: 40, depth: 30, weight: 2, destination_address: 'Rua da Imprensa, 48 - Gramado',
                                         recipient: 'João Cerqueira', recipient_phone: '54988475495', total_distance: 1120)
    
    login_as admin  
    visit edit_service_order_path(service_order)
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

    expect(page).to have_content 'Não foi possível atualizar a Ordem de Serviço'
    expect(page).not_to have_content 'Ordem de Serviço atualizada com sucesso'
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
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    service_order = ServiceOrder.create!(source_address: 'Rua Paracatu, 957 - São Paulo', product_code: 'AMDNF-EOLDF-SHNFK',
                                         height: 70, width: 40, depth: 30, weight: 2, destination_address: 'Rua da Imprensa, 48 - Gramado',
                                         recipient: 'João Cerqueira', recipient_phone: '54988475495', total_distance: 1120)
    
    login_as admin  
    visit edit_service_order_path(service_order)
    fill_in 'Código do produto', with: 'A'
    fill_in 'Altura', with: '0'
    fill_in 'Largura', with: '0'
    fill_in 'Profundidade', with: '-19'
    fill_in 'Peso', with: '0'
    fill_in 'Telefone', with: '999913748593'
    fill_in 'Distância total', with: '0'
    click_button 'Salvar'

    expect(page).to have_content 'Código do produto não possui o tamanho esperado (17 caracteres)'
    expect(page).to have_content 'Altura deve ser maior que 0'
    expect(page).to have_content 'Largura deve ser maior que 0'
    expect(page).to have_content 'Profundidade deve ser maior que 0'
    expect(page).to have_content 'Peso deve ser maior que 0'
    expect(page).to have_content 'Telefone é muito longo (máximo: 11 caracteres)'
    expect(page).to have_content 'Distância total deve ser maior que 0'
  end

  it 'sem modificar os campos' do
    admin = User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
    service_order = ServiceOrder.create!(source_address: 'Rua Paracatu, 957 - São Paulo', product_code: 'AMDNF-EOLDF-SHNFK',
                                         height: 70, width: 40, depth: 30, weight: 2, destination_address: 'Rua da Imprensa, 48 - Gramado',
                                         recipient: 'João Cerqueira', recipient_phone: '54988475495', total_distance: 1120)
    
    login_as admin  
    visit edit_service_order_path(service_order)
    click_button 'Salvar'
    expect(page).to have_content 'Nenhuma modificação encontrada'
  end
end