ModeOfTransport.destroy_all
User.destroy_all
Vehicle.destroy_all

ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                        minimum_weight: 0, maximum_weight: 200, flat_rate: 15, status: :active)
ModeOfTransport.create!(name:'Econômica', minimum_distance: 100, maximum_distance: 4000, 
                        minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)     
ModeOfTransport.create!(name:'Rapidex', minimum_distance: 0, maximum_distance: 1000, 
                        minimum_weight: 0, maximum_weight: 150, flat_rate: 13)     
ModeOfTransport.create!(name:'Disk Envios', minimum_distance: 10, maximum_distance: 5000, 
                        minimum_weight: 2, maximum_weight: 1000, flat_rate: 8, status: :active)     
ModeOfTransport.create!(name:'Frota Exclusiva', minimum_distance: 200, maximum_distance: 6000, 
                        minimum_weight: 70, maximum_weight: 2000, flat_rate: 10)     
ModeOfTransport.create!(name:'Ramos Transportes', minimum_distance: 0, maximum_distance: 800, 
                        minimum_weight: 10, maximum_weight: 250, flat_rate: 8)     
ModeOfTransport.create!(name:'Rota 10', minimum_distance: 50, maximum_distance: 1200, 
                        minimum_weight: 0, maximum_weight: 2900, flat_rate: 5)                       
ModeOfTransport.create!(name:'MTR Cargas', minimum_distance: 60, maximum_distance: 700, 
                        minimum_weight: 1, maximum_weight: 400, flat_rate: 7, status: :active)     

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