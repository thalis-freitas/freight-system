require 'rails_helper'

describe 'Usuário autenticado busca por ordens de serviço' do 
  it 'a partir do menu' do 
    user = User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')
    login_as user 
    visit root_path
    within('nav') do 
      expect(page).to have_field 'query'
      expect(page).to have_button 'Buscar OS'
    end
  end  

  it 'e encontra uma ordem de serviço' do 
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('123ABCDEFGHI456')
    ServiceOrder.create!(source_address: 'Travessa Antônio Ferreira, 980 | Capanema - PA', product_code: 'AANDM-OEHFM-SLDMF',
                         height: 390, width: 248, depth: 383, weight: 3200, destination_address: 'Avenida Afonso Pena, 1029 | Belo Horizonte - MG',
                         recipient: 'Sofia dos Santos', recipient_phone: '31999483042', total_distance: 1615)
    user = User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')
        
    login_as user 
    visit root_path
    fill_in 'query', with: 'ABC'
    click_button 'Buscar OS'

    expect(page).to have_content 'Resultados da busca por ABC'
    expect(page).to have_content '1 ordem de serviço encontrada'
    expect(page).to have_content 'Endereço de origem: Travessa Antônio Ferreira, 980 | Capanema - PA'
    expect(page).to have_content 'Código 123ABCDEFGHI456'
    expect(page).to have_link '123ABCDEFGHI456'
  end

  it 'e encontra múltiplas ordens de serviço' do 
    economica = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                        minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)    
    PriceByWeight.create!(minimum_weight: 20, maximum_weight: 120, value: 0, mode_of_transport: economica)
    PricePerDistance.create!(minimum_distance: 1501, maximum_distance: 2500, rate: 380, mode_of_transport: economica)
    Deadline.create!(minimum_distance: 1001, maximum_distance: 2000, estimated_time: 336, mode_of_transport: economica)
    vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                              maximum_capacity: 23000)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC123456789DEF')
    ServiceOrder.create!(source_address: 'Travessa Antônio Ferreira, 980 | Capanema - PA', product_code: 'AANDM-OEHFM-SLDMF',
                         height: 390, width: 248, depth: 383, weight: 3200, destination_address: 'Avenida Afonso Pena, 1029 | Belo Horizonte - MG',
                         recipient: 'Sofia dos Santos', recipient_phone: '31999483042', total_distance: 1615)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('123ABCDEFGHI456')
    service_order = ServiceOrder.create!(source_address: 'Avenida Tocantins, 384 | Jataí - GO', product_code: 'SBDNF-PRIFM-SHFMD',
                                         height: 87, width: 135, depth: 38, weight: 55, destination_address: 'Zona Portuária, 30 - Rio Grande',
                                         recipient: 'Maurício Peixoto', recipient_phone: '53933204958', total_distance: 1730,
                                         mode_of_transport: economica, vehicle: vehicle, started_in: 3.week.ago, status: :in_progress)
    service_order.register_price_and_deadline                                     
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('000ZZZZZZZZZ000')
    ServiceOrder.create!(source_address: 'QE 11 Área Especial C, 12 | Brasília - DF', product_code: 'SMDKE-DLSME-WPDOS',
                         height: 300, width: 250, depth: 300, weight: 10000, destination_address: 'Avenida Governador José Malcher, 327 | Belém - PA',
                         recipient: 'Janete Garcia', recipient_phone: '91993470058', total_distance: 1960)   
    user = User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')
    
    login_as user 
    visit root_path
    fill_in 'query', with: 'ABC'
    click_button 'Buscar OS'

    expect(page).to have_content 'Resultados da busca por ABC'
    expect(page).to have_content '2 ordens de serviço encontradas'
    expect(page).to have_content 'Código ABC123456789DEF'
    expect(page).to have_link 'ABC123456789DEF'
    expect(page).to have_content 'Endereço de origem: Travessa Antônio Ferreira, 980 | Capanema - PA'
    expect(page).to have_content 'Código 123ABCDEFGHI456'
    expect(page).to have_link '123ABCDEFGHI456'
    expect(page).to have_content 'Endereço de origem: Avenida Tocantins, 384 | Jataí - GO'
    expect(page).not_to have_content 'Código 000ZZZZZZZZZ000'
    expect(page).not_to have_content 'Endereço de origem: QE 11 Área Especial C, 12 | Brasília - DF'
  end

  it 'sem preencher o campo' do 
    user = User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')
    
    login_as user 
    visit root_path
    fill_in 'query', with: ''
    click_button 'Buscar OS'

    expect(page).to have_content 'É necessário preencher o campo para fazer a busca'
  end

  it 'e não encontra nenhuma ordem de serviço' do
    visit root_path
    fill_in 'query', with: 'ABC123456789DEF'
    click_on 'Rastrear entrega'
    expect(page).to have_content 'Nenhuma ordem de serviço encontrada'
  end
end