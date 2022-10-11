ModeOfTransport.destroy_all
PriceByWeight.destroy_all
PricePerDistance.destroy_all
Deadline.destroy_all
User.destroy_all
Vehicle.destroy_all

express = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                  minimum_weight: 0, maximum_weight: 200, flat_rate: 15, status: :active)
PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 1, mode_of_transport: express)
PriceByWeight.create!(minimum_weight: 51, maximum_weight: 100, value: 2, mode_of_transport: express)
PriceByWeight.create!(minimum_weight: 101, maximum_weight: 150, value: 3, mode_of_transport: express)
PriceByWeight.create!(minimum_weight: 151, maximum_weight: 200, value: 4, mode_of_transport: express)
PricePerDistance.create!(minimum_distance: 20, maximum_distance: 80, rate: 5, mode_of_transport: express)
PricePerDistance.create!(minimum_distance: 81, maximum_distance: 150, rate: 8, mode_of_transport: express)
PricePerDistance.create!(minimum_distance: 151, maximum_distance: 500, rate: 12, mode_of_transport: express)
PricePerDistance.create!(minimum_distance: 501, maximum_distance: 1000, rate: 25, mode_of_transport: express)
PricePerDistance.create!(minimum_distance: 1001, maximum_distance: 1500, rate: 35, mode_of_transport: express)
PricePerDistance.create!(minimum_distance: 1500, maximum_distance: 2000, rate: 50, mode_of_transport: express)
Deadline.create!(minimum_distance: 20, maximum_distance: 100, estimated_time: 3, mode_of_transport: express)
Deadline.create!(minimum_distance: 101, maximum_distance: 300, estimated_time: 8, mode_of_transport: express)
Deadline.create!(minimum_distance: 301, maximum_distance: 1000, estimated_time: 24, mode_of_transport: express)
Deadline.create!(minimum_distance: 1001, maximum_distance: 2000, estimated_time: 48, mode_of_transport: express)

economica = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                    minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)    
PriceByWeight.create!(minimum_weight: 20, maximum_weight: 120, value: 0, mode_of_transport: economica)
PriceByWeight.create!(minimum_weight: 121, maximum_weight: 300, value: 1, mode_of_transport: economica)
PriceByWeight.create!(minimum_weight: 301, maximum_weight: 450, value: 2, mode_of_transport: economica)
PriceByWeight.create!(minimum_weight: 451, maximum_weight: 700, value: 3, mode_of_transport: economica)
PriceByWeight.create!(minimum_weight: 701, maximum_weight: 800, value: 4, mode_of_transport: economica)
PricePerDistance.create!(minimum_distance: 500, maximum_distance: 1000, rate: 2, mode_of_transport: economica)
PricePerDistance.create!(minimum_distance: 1001, maximum_distance: 1500, rate: 5, mode_of_transport: economica)
PricePerDistance.create!(minimum_distance: 1501, maximum_distance: 2500, rate: 8, mode_of_transport: economica)
PricePerDistance.create!(minimum_distance: 2501, maximum_distance: 3500, rate: 12, mode_of_transport: economica)
PricePerDistance.create!(minimum_distance: 3501, maximum_distance: 4000, rate: 18, mode_of_transport: economica)
Deadline.create!(minimum_distance: 500, maximum_distance: 1000, estimated_time: 168, mode_of_transport: economica)
Deadline.create!(minimum_distance: 1001, maximum_distance: 2000, estimated_time: 336, mode_of_transport: economica)
Deadline.create!(minimum_distance: 2001, maximum_distance: 3000, estimated_time: 504, mode_of_transport: economica)
Deadline.create!(minimum_distance: 3001, maximum_distance: 4000, estimated_time: 672, mode_of_transport: economica)

rapidex = ModeOfTransport.create!(name:'Rapidex', minimum_distance: 0, maximum_distance: 1000, 
                                  minimum_weight: 0, maximum_weight: 150, flat_rate: 13)    
PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 2, mode_of_transport: rapidex)
PriceByWeight.create!(minimum_weight: 51, maximum_weight: 100, value: 4, mode_of_transport: rapidex)
PriceByWeight.create!(minimum_weight: 101, maximum_weight: 150, value: 6, mode_of_transport: rapidex)
PricePerDistance.create!(minimum_distance: 0, maximum_distance: 100, rate: 5, mode_of_transport: rapidex)
PricePerDistance.create!(minimum_distance: 101, maximum_distance: 400, rate: 9, mode_of_transport: rapidex)
PricePerDistance.create!(minimum_distance: 401, maximum_distance: 700, rate: 13, mode_of_transport: rapidex)
PricePerDistance.create!(minimum_distance: 701, maximum_distance: 1000, rate: 16, mode_of_transport: rapidex)
Deadline.create!(minimum_distance: 0, maximum_distance: 100, estimated_time: 4, mode_of_transport: rapidex)
Deadline.create!(minimum_distance: 101, maximum_distance: 400, estimated_time: 8, mode_of_transport: rapidex)
Deadline.create!(minimum_distance: 401, maximum_distance: 750, estimated_time: 20, mode_of_transport: rapidex)
Deadline.create!(minimum_distance: 751, maximum_distance: 1000, estimated_time: 36, mode_of_transport: rapidex)
     
disk_envios = ModeOfTransport.create!(name:'Disk Envios', minimum_distance: 800, maximum_distance: 5000, 
                                      minimum_weight: 30, maximum_weight: 1000, flat_rate: 8, status: :active)     
PriceByWeight.create!(minimum_weight: 30, maximum_weight: 200, value: 0, mode_of_transport: disk_envios)
PriceByWeight.create!(minimum_weight: 201, maximum_weight: 400, value: 1, mode_of_transport: disk_envios)
PriceByWeight.create!(minimum_weight: 401, maximum_weight: 600, value: 2, mode_of_transport: disk_envios)
PriceByWeight.create!(minimum_weight: 601, maximum_weight: 800, value: 3, mode_of_transport: disk_envios)
PriceByWeight.create!(minimum_weight: 801, maximum_weight: 1000, value: 4, mode_of_transport: disk_envios)
PricePerDistance.create!(minimum_distance: 800, maximum_distance: 2000, rate: 10, mode_of_transport: disk_envios)
PricePerDistance.create!(minimum_distance: 2000, maximum_distance: 3500, rate: 15, mode_of_transport: disk_envios)
PricePerDistance.create!(minimum_distance: 3501, maximum_distance: 5000, rate: 20, mode_of_transport: disk_envios)
Deadline.create!(minimum_distance: 800, maximum_distance: 1500, estimated_time: 72, mode_of_transport: disk_envios)
Deadline.create!(minimum_distance: 1501, maximum_distance: 2000, estimated_time: 144, mode_of_transport: disk_envios)
Deadline.create!(minimum_distance: 2001, maximum_distance: 2850, estimated_time: 216, mode_of_transport: disk_envios)
Deadline.create!(minimum_distance: 2851, maximum_distance: 3300, estimated_time: 288, mode_of_transport: disk_envios)
Deadline.create!(minimum_distance: 3301, maximum_distance: 4000, estimated_time: 360, mode_of_transport: disk_envios)
Deadline.create!(minimum_distance: 4001, maximum_distance: 5000, estimated_time: 432, mode_of_transport: disk_envios)
         

frota_exclusiva = ModeOfTransport.create!(name:'Frota Exclusiva', minimum_distance: 200, maximum_distance: 6000, 
                                          minimum_weight: 70, maximum_weight: 2000, flat_rate: 10)   
PriceByWeight.create!(minimum_weight: 70, maximum_weight: 500, value: 1, mode_of_transport: frota_exclusiva)
PriceByWeight.create!(minimum_weight: 501, maximum_weight: 1000, value: 2, mode_of_transport: frota_exclusiva)
PriceByWeight.create!(minimum_weight: 1001, maximum_weight: 1500, value: 3, mode_of_transport: frota_exclusiva)
PriceByWeight.create!(minimum_weight: 1501, maximum_weight: 2000, value: 4, mode_of_transport: frota_exclusiva)
PricePerDistance.create!(minimum_distance: 200, maximum_distance: 800, rate: 8, mode_of_transport: frota_exclusiva)
PricePerDistance.create!(minimum_distance: 801, maximum_distance: 1500, rate: 18, mode_of_transport: frota_exclusiva)
PricePerDistance.create!(minimum_distance: 1501, maximum_distance: 3000, rate: 25, mode_of_transport: frota_exclusiva)
PricePerDistance.create!(minimum_distance: 3001, maximum_distance: 6000, rate: 45, mode_of_transport: frota_exclusiva)
Deadline.create!(minimum_distance: 200, maximum_distance: 800, estimated_time: 24, mode_of_transport: frota_exclusiva)
Deadline.create!(minimum_distance: 801, maximum_distance: 1500, estimated_time: 72, mode_of_transport: frota_exclusiva)
Deadline.create!(minimum_distance: 1501, maximum_distance: 3000, estimated_time: 120, mode_of_transport: frota_exclusiva)
Deadline.create!(minimum_distance: 4001, maximum_distance: 6000, estimated_time: 216, mode_of_transport: frota_exclusiva)
         
ramos_transportes = ModeOfTransport.create!(name:'Ramos Transportes', minimum_distance: 0, maximum_distance: 800, 
                                            minimum_weight: 10, maximum_weight: 250, flat_rate: 8) 
PriceByWeight.create!(minimum_weight: 10, maximum_weight: 40, value: 0, mode_of_transport: ramos_transportes)
PriceByWeight.create!(minimum_weight: 41, maximum_weight: 90, value: 1, mode_of_transport: ramos_transportes)
PriceByWeight.create!(minimum_weight: 91, maximum_weight: 150, value: 2, mode_of_transport: ramos_transportes)
PriceByWeight.create!(minimum_weight: 151, maximum_weight: 250, value: 3, mode_of_transport: ramos_transportes)
PricePerDistance.create!(minimum_distance: 0, maximum_distance: 80, rate: 4, mode_of_transport: ramos_transportes)
PricePerDistance.create!(minimum_distance: 81, maximum_distance: 150, rate: 6, mode_of_transport: ramos_transportes)
PricePerDistance.create!(minimum_distance: 151, maximum_distance: 400, rate: 9, mode_of_transport: ramos_transportes)
PricePerDistance.create!(minimum_distance: 401, maximum_distance: 800, rate: 14, mode_of_transport: ramos_transportes)
Deadline.create!(minimum_distance: 0, maximum_distance: 200, estimated_time: 36, mode_of_transport: ramos_transportes)
Deadline.create!(minimum_distance: 201, maximum_distance: 500, estimated_time: 72, mode_of_transport: ramos_transportes)
Deadline.create!(minimum_distance: 501, maximum_distance: 800, estimated_time: 120, mode_of_transport: ramos_transportes)

rota_10 = ModeOfTransport.create!(name:'Rota 10', minimum_distance: 50, maximum_distance: 1200, 
                                  minimum_weight: 200, maximum_weight: 2900, flat_rate: 5)
PriceByWeight.create!(minimum_weight: 200, maximum_weight: 800, value: 0, mode_of_transport: rota_10)
PriceByWeight.create!(minimum_weight: 801, maximum_weight: 1400, value: 3, mode_of_transport: rota_10)
PriceByWeight.create!(minimum_weight: 1401, maximum_weight: 2000, value: 4, mode_of_transport: rota_10)
PriceByWeight.create!(minimum_weight: 2001, maximum_weight: 2600, value: 5, mode_of_transport: rota_10)
PriceByWeight.create!(minimum_weight: 2601, maximum_weight: 2900, value: 6, mode_of_transport: rota_10)
PricePerDistance.create!(minimum_distance: 50, maximum_distance: 150, rate: 7, mode_of_transport: rota_10)
PricePerDistance.create!(minimum_distance: 151, maximum_distance: 400, rate: 11, mode_of_transport: rota_10)
PricePerDistance.create!(minimum_distance: 401, maximum_distance: 800, rate: 13, mode_of_transport: rota_10)
PricePerDistance.create!(minimum_distance: 801, maximum_distance: 1200, rate: 16, mode_of_transport: rota_10)
Deadline.create!(minimum_distance: 50, maximum_distance: 200, estimated_time: 24, mode_of_transport: rota_10)
Deadline.create!(minimum_distance: 201, maximum_distance: 600, estimated_time: 72, mode_of_transport: rota_10)
Deadline.create!(minimum_distance: 601, maximum_distance: 900, estimated_time: 120, mode_of_transport: rota_10)
Deadline.create!(minimum_distance: 901, maximum_distance: 1200, estimated_time: 168, mode_of_transport: rota_10)

mtr_cargas = ModeOfTransport.create!(name:'MTR Cargas', minimum_distance: 60, maximum_distance: 700, 
                                     minimum_weight: 50, maximum_weight: 400, flat_rate: 7, status: :active)     
PriceByWeight.create!(minimum_weight: 50, maximum_weight: 100, value: 0, mode_of_transport: mtr_cargas)
PriceByWeight.create!(minimum_weight: 101, maximum_weight: 200, value: 1, mode_of_transport: mtr_cargas)
PriceByWeight.create!(minimum_weight: 201, maximum_weight: 300, value: 3, mode_of_transport: mtr_cargas)
PriceByWeight.create!(minimum_weight: 301, maximum_weight: 400, value: 5, mode_of_transport: mtr_cargas)
PricePerDistance.create!(minimum_distance: 60, maximum_distance: 200, rate: 5, mode_of_transport: mtr_cargas)
PricePerDistance.create!(minimum_distance: 201, maximum_distance: 450, rate: 10, mode_of_transport: mtr_cargas)
PricePerDistance.create!(minimum_distance: 451, maximum_distance: 700, rate: 14, mode_of_transport: mtr_cargas)
Deadline.create!(minimum_distance: 60, maximum_distance: 200, estimated_time: 24, mode_of_transport: mtr_cargas)
Deadline.create!(minimum_distance: 201, maximum_distance: 450, estimated_time: 96, mode_of_transport: mtr_cargas)
Deadline.create!(minimum_distance: 451, maximum_distance: 700, estimated_time: 144, mode_of_transport: mtr_cargas)

User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')
User.create!(name: 'Janete de Jesus', email: 'janete@sistemadefrete.com.br', password: 'pass1234')
User.create!(name: 'Lara Machado', email: 'lara@sistemadefrete.com.br', password: 'pass1234', role: :admin)
User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)
 
Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                maximum_capacity: 23000)
Vehicle.create!(nameplate: 'IOC0693', brand: 'KIA', model: 'BONGO K 2500', year_of_manufacture: '2015', 
                maximum_capacity: 3400, status: :in_maintenance)
Vehicle.create!(nameplate: 'AKL7566', brand: 'Mercedez Benz', model: 'ATEGO 1315', year_of_manufacture: '2014',
                maximum_capacity: 13000)
Vehicle.create!(nameplate: 'HQZ9585', brand: 'Volvo', model: 'VM 310', year_of_manufacture: '2016', 
                maximum_capacity: 17500, status: :in_maintenance)
Vehicle.create!(nameplate: 'KER0414', brand: 'Volks', model: 'Constelallation 17.250', year_of_manufacture: '2012',
                maximum_capacity: 16000)
Vehicle.create!(nameplate: 'HUX6583', brand: 'Renault', model: 'Master', year_of_manufacture: '2015', 
                maximum_capacity: 3500, status: :in_maintenance)
Vehicle.create!(nameplate: 'ISX8398', brand: 'Mercedez Benz', model: '710 PLUS', year_of_manufacture: '2020',
                maximum_capacity: 6700)
Vehicle.create!(nameplate: 'JZZ2991', brand: 'Iveco', model: 'Tector 170 E 25', year_of_manufacture: '2012', 
                maximum_capacity: 17000, status: :in_maintenance)
                