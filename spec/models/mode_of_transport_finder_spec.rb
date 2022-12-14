require 'rails_helper'
describe '#compatible?' do
  it 'retorna true quando a modalidade de transporte for compatível com a ordem de serviço' do
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20, maximum_distance: 2000,
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 1500,
                                                status: :active)
    service_order = ServiceOrder.create!(source_address: 'Avenida Getúlio Vargas, 250 - Feira de Santana',
                                         product_code: 'MDKSJ-CADGM-ASM24', height: 120,
                                         width: 65, depth: 70, weight: 12,
                                         destination_address: 'Avenida São Rafael, 478 - Salvador',
                                         recipient: 'Joana Matos', recipient_phone: '71999284839',
                                         total_distance: 100)
    expect(ModeOfTransportFinder.new(mode_of_transport, service_order).compatible?).to eq true
  end

  it 'retorna false quando a modalidade de transporte não for compatível com a ordem de serviço' do
    mode_of_transport = ModeOfTransport.create!(name: 'Econômica', minimum_distance: 500, maximum_distance: 4000,
                                                minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)
    service_order = ServiceOrder.create!(source_address: 'Avenida Getúlio Vargas, 250 - Feira de Santana',
                                         product_code: 'MDKSJ-CADGM-ASM24', height: 120,
                                         width: 65, depth: 70, weight: 12,
                                         destination_address: 'Avenida São Rafael, 478 - Salvador',
                                         recipient: 'Joana Matos', recipient_phone: '71999284839',
                                         total_distance: 100)
    expect(ModeOfTransportFinder.new(mode_of_transport, service_order).compatible?).to eq false
  end
end

describe '#calculate_price' do
  it 'retorna o preço de uma modalidade de transporte para uma ordem de serviço em centavos' do
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20, maximum_distance: 2000,
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 1500,
                                                status: :active)
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 100, mode_of_transport:)
    PricePerDistance.create!(minimum_distance: 81, maximum_distance: 150, rate: 850,
                             mode_of_transport:)
    Deadline.create!(minimum_distance: 20, maximum_distance: 100, estimated_time: 3,
                     mode_of_transport:)

    service_order = ServiceOrder.create!(source_address: 'Avenida Getúlio Vargas, 250 - Feira de Santana',
                                         product_code: 'MDKSJ-CADGM-ASM24', height: 120,
                                         width: 65, depth: 70, weight: 12,
                                         destination_address: 'Avenida São Rafael, 478 - Salvador',
                                         recipient: 'Joana Matos', recipient_phone: '71999284839',
                                         total_distance: 100)

    expect(ModeOfTransportFinder.new(mode_of_transport, service_order).calculate_price).to eq 12_350
  end
end

describe '#calculate_deadline' do
  it 'retorna o prazo de uma modalidade de transporte para uma ordem de serviço em horas' do
    mode_of_transport = ModeOfTransport.create!(name: 'Express', minimum_distance: 20, maximum_distance: 2000,
                                                minimum_weight: 0, maximum_weight: 200, flat_rate: 1500,
                                                status: :active)
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 100, mode_of_transport:)
    PricePerDistance.create!(minimum_distance: 81, maximum_distance: 150, rate: 850,
                             mode_of_transport:)
    Deadline.create!(minimum_distance: 20, maximum_distance: 100, estimated_time: 3,
                     mode_of_transport:)

    service_order = ServiceOrder.create!(source_address: 'Avenida Getúlio Vargas, 250 - Feira de Santana',
                                         product_code: 'MDKSJ-CADGM-ASM24', height: 120,
                                         width: 65, depth: 70, weight: 12,
                                         destination_address: 'Avenida São Rafael, 478 - Salvador',
                                         recipient: 'Joana Matos', recipient_phone: '71999284839',
                                         total_distance: 100)

    expect(ModeOfTransportFinder.new(mode_of_transport, service_order).calculate_deadline).to eq 3
  end
end
