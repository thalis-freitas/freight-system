require 'rails_helper'

describe 'Usuário vê ordens de serviço pendentes' do
  it 'na página inicial' do
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789DEF')
    ServiceOrder.create!(source_address: 'Avenida Getúlio Vargas, 250 - Feira de Santana',
                         product_code: 'MDKSJ-CADGM-ASM24',
                         height: 120, width: 65, depth: 70, weight: 12,
                         destination_address: 'Avenida São Rafael, 478 - Salvador',
                         recipient: 'Joana Matos', recipient_phone: '71999284839', total_distance: 100)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('123ABCDEFGHI456')
    ServiceOrder.create!(source_address: 'Rua José Pacheco, 25 - Maranguape', product_code: 'MDKSJ-RACKH-ASM24',
                         height: 50, width: 120, depth: 40, weight: 8,
                         destination_address: 'Rua Beatriz, 57 - Fortaleza',
                         recipient: 'Joana Matos', recipient_phone: '85999284839', total_distance: 30)

    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit root_path

    expect(page).to have_content 'Ordens de Serviço pendentes'
    expect(page).to have_link 'ABC123456789DEF'
    expect(page).to have_content 'Dimensões: 120cm x 65cm x 70cm'
    expect(page).to have_content 'Peso: 12kg'
    expect(page).to have_content 'Distância total: 100km'
    expect(page).to have_link '123ABCDEFGHI456'
    expect(page).to have_content 'Dimensões: 50cm x 120cm x 40cm'
    expect(page).to have_content 'Peso: 8kg'
    expect(page).to have_content 'Distância total: 30km'
  end

  it 'e não existem ordens de serviço pendentes' do
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    login_as user
    visit root_path
    expect(page).to have_content 'Nenhuma ordem de serviço pendente'
  end
end
