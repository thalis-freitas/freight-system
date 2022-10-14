require 'rails_helper'

describe 'Usuário vê modalidades de transporte compatíveis com a ordem de serviço' do 
  it 'se estiver autenticado' do 
    service_order = ServiceOrder.create!(source_address: 'Avenida Getúlio Vargas, 250 - Feira de Santana', product_code: 'MDKSJ-CADGM-ASM24',
                                         height: 120, width: 65, depth: 70, weight: 12, destination_address: 'Avenida São Rafael, 478 - Salvador',
                                         recipient: 'Joana Matos', recipient_phone: '71999284839', total_distance: 100)
    visit service_order_path(service_order)
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'a partir da página inicial' do 
    express = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                      minimum_weight: 0, maximum_weight: 200, flat_rate: 1500, status: :active)
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 100, mode_of_transport: express)
    PricePerDistance.create!(minimum_distance: 81, maximum_distance: 150, rate: 850, mode_of_transport: express)
    Deadline.create!(minimum_distance: 20, maximum_distance: 100, estimated_time: 3, mode_of_transport: express)

    economica = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                        minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)    

    rapidex = ModeOfTransport.create!(name:'Rapidex', minimum_distance: 0, maximum_distance: 1000, 
                                      minimum_weight: 0, maximum_weight: 150, flat_rate: 1300, status: :active)    
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 80, mode_of_transport: rapidex)
    PricePerDistance.create!(minimum_distance: 0, maximum_distance: 110, rate: 500, mode_of_transport: rapidex)
    Deadline.create!(minimum_distance: 0, maximum_distance: 100, estimated_time: 4, mode_of_transport: rapidex)

    service_order = ServiceOrder.create!(source_address: 'Avenida Getúlio Vargas, 250 - Feira de Santana', product_code: 'MDKSJ-CADGM-ASM24',
                                         height: 120, width: 65, depth: 70, weight: 12, destination_address: 'Avenida São Rafael, 478 - Salvador',
                                         recipient: 'Joana Matos', recipient_phone: '71999284839', total_distance: 100)
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    
    login_as user 
    visit service_order_path(service_order)
    expect(page).to have_content 'Modalidades de Transporte Compatíveis'
    expect(page).to have_content 'Express R$ 123,50 3 horas'
    expect(page).to have_content  'Rapidex R$ 98,00 4 horas'
    expect(page).not_to have_content 'Econômica'
  end

  it 'e modalidades inativas não devem ser consideradas' do 
    express = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                      minimum_weight: 0, maximum_weight: 200, flat_rate: 1500)
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 100, mode_of_transport: express)
    PricePerDistance.create!(minimum_distance: 81, maximum_distance: 150, rate: 850, mode_of_transport: express)
    Deadline.create!(minimum_distance: 20, maximum_distance: 100, estimated_time: 3, mode_of_transport: express)    

    rapidex = ModeOfTransport.create!(name:'Rapidex', minimum_distance: 0, maximum_distance: 1000, 
                                      minimum_weight: 0, maximum_weight: 150, flat_rate: 1300, status: :active)    
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 80, mode_of_transport: rapidex)
    PricePerDistance.create!(minimum_distance: 0, maximum_distance: 110, rate: 500, mode_of_transport: rapidex)
    Deadline.create!(minimum_distance: 0, maximum_distance: 100, estimated_time: 4, mode_of_transport: rapidex)

    service_order = ServiceOrder.create!(source_address: 'Avenida Getúlio Vargas, 250 - Feira de Santana', product_code: 'MDKSJ-CADGM-ASM24',
                                         height: 120, width: 65, depth: 70, weight: 12, destination_address: 'Avenida São Rafael, 478 - Salvador',
                                         recipient: 'Joana Matos', recipient_phone: '71999284839', total_distance: 100)
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
    
    login_as user 
    visit service_order_path(service_order)
    expect(page).to have_content 'Modalidades de Transporte Compatíveis'
    expect(page).not_to have_content 'Express R$ 123,50 3 horas'
    expect(page).to have_content  'Rapidex R$ 98,00 4 horas'
  end

  it 'e não existem modalidades de transporte compatíveis' do 
    service_order = ServiceOrder.create!(source_address: 'Avenida Getúlio Vargas, 250 - Feira de Santana', product_code: 'MDKSJ-CADGM-ASM24',
                                         height: 120, width: 65, depth: 70, weight: 12, destination_address: 'Avenida São Rafael, 478 - Salvador',
                                         recipient: 'Joana Matos', recipient_phone: '71999284839', total_distance: 100)
    user = User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')

    login_as user 
    visit service_order_path(service_order)
    expect(page).not_to have_content 'Modalidades de Transporte Compatíveis'
    expect(page).to have_content  'Nenhuma modalidade de transporte compatível'
  end
end