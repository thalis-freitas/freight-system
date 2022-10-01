ModeOfTransport.destroy_all
ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                        minimum_weight: 0, maximum_weight: 200, flat_rate: 15)
ModeOfTransport.create!(name:'Econômica', minimum_distance: 100, maximum_distance: 4000, 
                        minimum_weight: 20, maximum_weight: 800, flat_rate: 0)     
ModeOfTransport.create!(name:'Rapidex', minimum_distance: 0, maximum_distance: 1000, 
                        minimum_weight: 0, maximum_weight: 150, flat_rate: 13)     
ModeOfTransport.create!(name:'Disk Envios', minimum_distance: 10, maximum_distance: 5000, 
                        minimum_weight: 2, maximum_weight: 1000, flat_rate: 8)     
ModeOfTransport.create!(name:'Frota Exclusiva', minimum_distance: 200, maximum_distance: 6000, 
                        minimum_weight: 70, maximum_weight: 2000, flat_rate: 10)     
ModeOfTransport.create!(name:'Ramos Transportadora', minimum_distance: 0, maximum_distance: 800, 
                        minimum_weight: 10, maximum_weight: 250, flat_rate: 8)     
ModeOfTransport.create!(name:'Rota 10', minimum_distance: 50, maximum_distance: 1200, 
                        minimum_weight: 0, maximum_weight: 2900, flat_rate: 5)                       
ModeOfTransport.create!(name:'Envios e Cargas MTR', minimum_distance: 60, maximum_distance: 700, 
                        minimum_weight: 1, maximum_weight: 400, flat_rate: 7)     
                                               