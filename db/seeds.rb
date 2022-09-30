ModeOfTransport.destroy_all
ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
    minimum_weight: 0, maximum_weight: 5000, flat_rate: 1500)
ModeOfTransport.create!(name:'Econômica', minimum_distance: 100, maximum_distance: 4000, 
    minimum_weight: 20, maximum_weight: 3000, flat_rate: 500)