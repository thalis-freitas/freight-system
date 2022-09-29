ModeOfTransport.destroy_all
ModeOfTransport.create!(name:'Express', minimum_distance: 50, maximum_distance: 500, 
                        minimum_weight: 200, maximum_weight: 30000, flat_rate: 10)
ModeOfTransport.create!(name:'Econômica', minimum_distance: 100, maximum_distance: 1000, 
                        minimum_weight: 50, maximum_weight: 50000, flat_rate: 15)