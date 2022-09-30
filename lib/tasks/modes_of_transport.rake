namespace :modes_of_transport do
  desc "Popular a tabela modalidades de transporte"
  if Rails.env.development?
    task set_modes_of_transport: :environment do
      ModeOfTransport.create!(name:'Express', minimum_distance: 50, maximum_distance: 500, 
                              minimum_weight: 200, maximum_weight: 30000, flat_rate: 10)
      ModeOfTransport.create!(name:'Econômica', minimum_distance: 100, maximum_distance: 1000, 
                              minimum_weight: 50, maximum_weight: 50000, flat_rate: 15)
    end
  else
    puts 'Ops, você não está no ambiente de desenvolvimento'
  end
end
