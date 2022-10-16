economica = ModeOfTransport.create!(name:'Econômica', minimum_distance: 500, maximum_distance: 4000, 
                                    minimum_weight: 20, maximum_weight: 800, flat_rate: 0, status: :active)    
PriceByWeight.create!(minimum_weight: 20, maximum_weight: 120, value: 0, mode_of_transport: economica)
PriceByWeight.create!(minimum_weight: 121, maximum_weight: 300, value: 20, mode_of_transport: economica)
PriceByWeight.create!(minimum_weight: 301, maximum_weight: 450, value: 40, mode_of_transport: economica)
PriceByWeight.create!(minimum_weight: 451, maximum_weight: 700, value: 60, mode_of_transport: economica)
PriceByWeight.create!(minimum_weight: 701, maximum_weight: 800, value: 85, mode_of_transport: economica)
PricePerDistance.create!(minimum_distance: 500, maximum_distance: 1000, rate: 150, mode_of_transport: economica)
PricePerDistance.create!(minimum_distance: 1001, maximum_distance: 1500, rate: 220, mode_of_transport: economica)
PricePerDistance.create!(minimum_distance: 1501, maximum_distance: 2500, rate: 380, mode_of_transport: economica)
PricePerDistance.create!(minimum_distance: 2501, maximum_distance: 3500, rate: 460, mode_of_transport: economica)
PricePerDistance.create!(minimum_distance: 3501, maximum_distance: 4000, rate: 540, mode_of_transport: economica)
Deadline.create!(minimum_distance: 500, maximum_distance: 1000, estimated_time: 168, mode_of_transport: economica)
Deadline.create!(minimum_distance: 1001, maximum_distance: 2000, estimated_time: 336, mode_of_transport: economica)
Deadline.create!(minimum_distance: 2001, maximum_distance: 3000, estimated_time: 504, mode_of_transport: economica)
Deadline.create!(minimum_distance: 3001, maximum_distance: 4000, estimated_time: 672, mode_of_transport: economica)

express = ModeOfTransport.create!(name:'Express', minimum_distance: 20, maximum_distance: 2000, 
                                  minimum_weight: 0, maximum_weight: 200, flat_rate: 1500, status: :active)
PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 100, mode_of_transport: express)
PriceByWeight.create!(minimum_weight: 51, maximum_weight: 100, value: 150, mode_of_transport: express)
PriceByWeight.create!(minimum_weight: 101, maximum_weight: 150, value: 200, mode_of_transport: express)
PriceByWeight.create!(minimum_weight: 151, maximum_weight: 200, value: 250, mode_of_transport: express)
PricePerDistance.create!(minimum_distance: 20, maximum_distance: 80, rate: 500, mode_of_transport: express)
PricePerDistance.create!(minimum_distance: 81, maximum_distance: 150, rate: 850, mode_of_transport: express)
PricePerDistance.create!(minimum_distance: 151, maximum_distance: 500, rate: 1200, mode_of_transport: express)
PricePerDistance.create!(minimum_distance: 501, maximum_distance: 1000, rate: 2500, mode_of_transport: express)
PricePerDistance.create!(minimum_distance: 1001, maximum_distance: 1500, rate: 3550, mode_of_transport: express)
PricePerDistance.create!(minimum_distance: 1500, maximum_distance: 2000, rate: 5000, mode_of_transport: express)
Deadline.create!(minimum_distance: 20, maximum_distance: 100, estimated_time: 3, mode_of_transport: express)
Deadline.create!(minimum_distance: 101, maximum_distance: 300, estimated_time: 8, mode_of_transport: express)
Deadline.create!(minimum_distance: 301, maximum_distance: 1000, estimated_time: 24, mode_of_transport: express)
Deadline.create!(minimum_distance: 1001, maximum_distance: 2000, estimated_time: 48, mode_of_transport: express)

rapidex = ModeOfTransport.create!(name:'Rapidex', minimum_distance: 0, maximum_distance: 1000, 
                                  minimum_weight: 0, maximum_weight: 150, flat_rate: 1300)    
PriceByWeight.create!(minimum_weight: 0, maximum_weight: 50, value: 80, mode_of_transport: rapidex)
PriceByWeight.create!(minimum_weight: 51, maximum_weight: 100, value: 150, mode_of_transport: rapidex)
PriceByWeight.create!(minimum_weight: 101, maximum_weight: 150, value: 220, mode_of_transport: rapidex)
PricePerDistance.create!(minimum_distance: 0, maximum_distance: 100, rate: 500, mode_of_transport: rapidex)
PricePerDistance.create!(minimum_distance: 101, maximum_distance: 400, rate: 900, mode_of_transport: rapidex)
PricePerDistance.create!(minimum_distance: 401, maximum_distance: 700, rate: 1300, mode_of_transport: rapidex)
PricePerDistance.create!(minimum_distance: 701, maximum_distance: 1000, rate: 1600, mode_of_transport: rapidex)
Deadline.create!(minimum_distance: 0, maximum_distance: 100, estimated_time: 4, mode_of_transport: rapidex)
Deadline.create!(minimum_distance: 101, maximum_distance: 400, estimated_time: 8, mode_of_transport: rapidex)
Deadline.create!(minimum_distance: 401, maximum_distance: 750, estimated_time: 20, mode_of_transport: rapidex)
Deadline.create!(minimum_distance: 751, maximum_distance: 1000, estimated_time: 36, mode_of_transport: rapidex)
     
disk_envios = ModeOfTransport.create!(name:'Disk Envios', minimum_distance: 800, maximum_distance: 5000, 
                                      minimum_weight: 30, maximum_weight: 1000, flat_rate: 850, status: :active)     
PriceByWeight.create!(minimum_weight: 30, maximum_weight: 200, value: 10, mode_of_transport: disk_envios)
PriceByWeight.create!(minimum_weight: 201, maximum_weight: 400, value: 30, mode_of_transport: disk_envios)
PriceByWeight.create!(minimum_weight: 401, maximum_weight: 600, value: 55, mode_of_transport: disk_envios)
PriceByWeight.create!(minimum_weight: 601, maximum_weight: 800, value: 80, mode_of_transport: disk_envios)
PriceByWeight.create!(minimum_weight: 801, maximum_weight: 1000, value: 100, mode_of_transport: disk_envios)
PricePerDistance.create!(minimum_distance: 800, maximum_distance: 2000, rate: 1000, mode_of_transport: disk_envios)
PricePerDistance.create!(minimum_distance: 2000, maximum_distance: 3500, rate: 1500, mode_of_transport: disk_envios)
PricePerDistance.create!(minimum_distance: 3501, maximum_distance: 5000, rate: 2000, mode_of_transport: disk_envios)
Deadline.create!(minimum_distance: 800, maximum_distance: 1500, estimated_time: 72, mode_of_transport: disk_envios)
Deadline.create!(minimum_distance: 1501, maximum_distance: 2000, estimated_time: 144, mode_of_transport: disk_envios)
Deadline.create!(minimum_distance: 2001, maximum_distance: 2850, estimated_time: 216, mode_of_transport: disk_envios)
Deadline.create!(minimum_distance: 2851, maximum_distance: 3300, estimated_time: 288, mode_of_transport: disk_envios)
Deadline.create!(minimum_distance: 3301, maximum_distance: 4000, estimated_time: 360, mode_of_transport: disk_envios)
Deadline.create!(minimum_distance: 4001, maximum_distance: 5000, estimated_time: 432, mode_of_transport: disk_envios)
         

frota_exclusiva = ModeOfTransport.create!(name:'Frota Exclusiva', minimum_distance: 200, maximum_distance: 6000, 
                                          minimum_weight: 70, maximum_weight: 2000, flat_rate: 1075)   
PriceByWeight.create!(minimum_weight: 70, maximum_weight: 500, value: 90, mode_of_transport: frota_exclusiva)
PriceByWeight.create!(minimum_weight: 501, maximum_weight: 1000, value: 110, mode_of_transport: frota_exclusiva)
PriceByWeight.create!(minimum_weight: 1001, maximum_weight: 1500, value: 125, mode_of_transport: frota_exclusiva)
PriceByWeight.create!(minimum_weight: 1501, maximum_weight: 2000, value: 150, mode_of_transport: frota_exclusiva)
PricePerDistance.create!(minimum_distance: 200, maximum_distance: 800, rate: 800, mode_of_transport: frota_exclusiva)
PricePerDistance.create!(minimum_distance: 801, maximum_distance: 1500, rate: 1800, mode_of_transport: frota_exclusiva)
PricePerDistance.create!(minimum_distance: 1501, maximum_distance: 3000, rate: 2500, mode_of_transport: frota_exclusiva)
PricePerDistance.create!(minimum_distance: 3001, maximum_distance: 6000, rate: 4500, mode_of_transport: frota_exclusiva)
Deadline.create!(minimum_distance: 200, maximum_distance: 800, estimated_time: 24, mode_of_transport: frota_exclusiva)
Deadline.create!(minimum_distance: 801, maximum_distance: 1500, estimated_time: 72, mode_of_transport: frota_exclusiva)
Deadline.create!(minimum_distance: 1501, maximum_distance: 3000, estimated_time: 120, mode_of_transport: frota_exclusiva)
Deadline.create!(minimum_distance: 4001, maximum_distance: 6000, estimated_time: 216, mode_of_transport: frota_exclusiva)
         
ramos_transportes = ModeOfTransport.create!(name:'Ramos Transportes', minimum_distance: 0, maximum_distance: 800, 
                                            minimum_weight: 10, maximum_weight: 250, flat_rate: 825) 
PriceByWeight.create!(minimum_weight: 10, maximum_weight: 40, value: 5, mode_of_transport: ramos_transportes)
PriceByWeight.create!(minimum_weight: 41, maximum_weight: 90, value: 25, mode_of_transport: ramos_transportes)
PriceByWeight.create!(minimum_weight: 91, maximum_weight: 150, value: 45, mode_of_transport: ramos_transportes)
PriceByWeight.create!(minimum_weight: 151, maximum_weight: 250, value: 65, mode_of_transport: ramos_transportes)
PricePerDistance.create!(minimum_distance: 0, maximum_distance: 80, rate: 400, mode_of_transport: ramos_transportes)
PricePerDistance.create!(minimum_distance: 81, maximum_distance: 150, rate: 600, mode_of_transport: ramos_transportes)
PricePerDistance.create!(minimum_distance: 151, maximum_distance: 400, rate: 900, mode_of_transport: ramos_transportes)
PricePerDistance.create!(minimum_distance: 401, maximum_distance: 800, rate: 1400, mode_of_transport: ramos_transportes)
Deadline.create!(minimum_distance: 0, maximum_distance: 200, estimated_time: 36, mode_of_transport: ramos_transportes)
Deadline.create!(minimum_distance: 201, maximum_distance: 500, estimated_time: 72, mode_of_transport: ramos_transportes)
Deadline.create!(minimum_distance: 501, maximum_distance: 800, estimated_time: 120, mode_of_transport: ramos_transportes)

rota_10 = ModeOfTransport.create!(name:'Rota 10', minimum_distance: 50, maximum_distance: 1200, 
                                  minimum_weight: 5000, maximum_weight: 23000, flat_rate: 500)
PriceByWeight.create!(minimum_weight: 5000, maximum_weight: 8000, value: 15, mode_of_transport: rota_10)
PriceByWeight.create!(minimum_weight: 8001, maximum_weight: 14000, value: 45, mode_of_transport: rota_10)
PriceByWeight.create!(minimum_weight: 14001, maximum_weight: 20000, value: 80, mode_of_transport: rota_10)
PriceByWeight.create!(minimum_weight: 20001, maximum_weight: 23000, value: 99, mode_of_transport: rota_10)
PricePerDistance.create!(minimum_distance: 50, maximum_distance: 150, rate: 700, mode_of_transport: rota_10)
PricePerDistance.create!(minimum_distance: 151, maximum_distance: 400, rate: 1100, mode_of_transport: rota_10)
PricePerDistance.create!(minimum_distance: 401, maximum_distance: 800, rate: 1300, mode_of_transport: rota_10)
PricePerDistance.create!(minimum_distance: 801, maximum_distance: 1200, rate: 1600, mode_of_transport: rota_10)
Deadline.create!(minimum_distance: 50, maximum_distance: 200, estimated_time: 24, mode_of_transport: rota_10)
Deadline.create!(minimum_distance: 201, maximum_distance: 600, estimated_time: 72, mode_of_transport: rota_10)
Deadline.create!(minimum_distance: 601, maximum_distance: 900, estimated_time: 120, mode_of_transport: rota_10)
Deadline.create!(minimum_distance: 901, maximum_distance: 1200, estimated_time: 168, mode_of_transport: rota_10)

mtr_cargas = ModeOfTransport.create!(name:'MTR Cargas', minimum_distance: 60, maximum_distance: 700, 
                                     minimum_weight: 50, maximum_weight: 400, flat_rate: 700, status: :active)     
PriceByWeight.create!(minimum_weight: 50, maximum_weight: 100, value: 25, mode_of_transport: mtr_cargas)
PriceByWeight.create!(minimum_weight: 101, maximum_weight: 200, value: 50, mode_of_transport: mtr_cargas)
PriceByWeight.create!(minimum_weight: 201, maximum_weight: 300, value: 75, mode_of_transport: mtr_cargas)
PriceByWeight.create!(minimum_weight: 301, maximum_weight: 400, value: 100, mode_of_transport: mtr_cargas)
PricePerDistance.create!(minimum_distance: 60, maximum_distance: 200, rate: 500, mode_of_transport: mtr_cargas)
PricePerDistance.create!(minimum_distance: 201, maximum_distance: 450, rate: 1000, mode_of_transport: mtr_cargas)
PricePerDistance.create!(minimum_distance: 451, maximum_distance: 700, rate: 1400, mode_of_transport: mtr_cargas)
Deadline.create!(minimum_distance: 60, maximum_distance: 200, estimated_time: 24, mode_of_transport: mtr_cargas)
Deadline.create!(minimum_distance: 201, maximum_distance: 450, estimated_time: 96, mode_of_transport: mtr_cargas)
Deadline.create!(minimum_distance: 451, maximum_distance: 700, estimated_time: 144, mode_of_transport: mtr_cargas)

transitar = ModeOfTransport.create!(name:'Transitar', minimum_distance: 0, maximum_distance: 450, 
                                    minimum_weight: 0, maximum_weight: 360, flat_rate: 800, status: :active)     
PriceByWeight.create!(minimum_weight: 0, maximum_weight: 80, value: 15, mode_of_transport: transitar)
PriceByWeight.create!(minimum_weight: 81, maximum_weight: 160, value: 25, mode_of_transport: transitar)
PriceByWeight.create!(minimum_weight: 161, maximum_weight: 240, value: 45, mode_of_transport: transitar)
PriceByWeight.create!(minimum_weight: 241, maximum_weight: 300, value: 65, mode_of_transport: transitar)
PriceByWeight.create!(minimum_weight: 301, maximum_weight: 360, value: 90, mode_of_transport: transitar)
PricePerDistance.create!(minimum_distance: 0, maximum_distance: 90, rate: 350, mode_of_transport: transitar)
PricePerDistance.create!(minimum_distance: 91, maximum_distance: 150, rate: 500, mode_of_transport: transitar)
PricePerDistance.create!(minimum_distance: 151, maximum_distance: 250, rate: 650, mode_of_transport: transitar)
PricePerDistance.create!(minimum_distance: 251, maximum_distance: 320, rate: 800, mode_of_transport: transitar)
PricePerDistance.create!(minimum_distance: 321, maximum_distance: 450, rate: 950, mode_of_transport: transitar)
Deadline.create!(minimum_distance: 0, maximum_distance: 100, estimated_time: 24, mode_of_transport: transitar)
Deadline.create!(minimum_distance: 101, maximum_distance: 200, estimated_time: 48, mode_of_transport: transitar)
Deadline.create!(minimum_distance: 201, maximum_distance: 300, estimated_time: 72, mode_of_transport: transitar)
Deadline.create!(minimum_distance: 301, maximum_distance: 450, estimated_time: 96, mode_of_transport: transitar)

via_cargas = ModeOfTransport.create!(name:'Via Cargas', minimum_distance: 0, maximum_distance: 950, 
                                     minimum_weight: 0, maximum_weight: 870, flat_rate: 450, status: :active)     
PriceByWeight.create!(minimum_weight: 0, maximum_weight: 180, value: 24, mode_of_transport: via_cargas)
PriceByWeight.create!(minimum_weight: 181, maximum_weight: 360, value: 39, mode_of_transport: via_cargas)
PriceByWeight.create!(minimum_weight: 360, maximum_weight: 580, value: 47, mode_of_transport: via_cargas)
PriceByWeight.create!(minimum_weight: 581, maximum_weight: 790, value: 58, mode_of_transport: via_cargas)
PriceByWeight.create!(minimum_weight: 791, maximum_weight: 870, value: 65, mode_of_transport: via_cargas)
PricePerDistance.create!(minimum_distance: 0, maximum_distance: 200, rate: 460, mode_of_transport: via_cargas)
PricePerDistance.create!(minimum_distance: 201, maximum_distance: 400, rate: 790, mode_of_transport: via_cargas)
PricePerDistance.create!(minimum_distance: 401, maximum_distance: 600, rate: 1000, mode_of_transport: via_cargas)
PricePerDistance.create!(minimum_distance: 601, maximum_distance: 800, rate: 1250, mode_of_transport: via_cargas)
PricePerDistance.create!(minimum_distance: 801, maximum_distance: 950, rate: 1385, mode_of_transport: via_cargas)
Deadline.create!(minimum_distance: 0, maximum_distance: 250, estimated_time: 48, mode_of_transport: via_cargas)
Deadline.create!(minimum_distance: 251, maximum_distance: 490, estimated_time: 96, mode_of_transport: via_cargas)
Deadline.create!(minimum_distance: 491, maximum_distance: 680, estimated_time: 144, mode_of_transport: via_cargas)
Deadline.create!(minimum_distance: 681, maximum_distance: 760, estimated_time: 192, mode_of_transport: via_cargas)
Deadline.create!(minimum_distance: 761, maximum_distance: 950, estimated_time: 240, mode_of_transport: via_cargas)

carga_pesada = ModeOfTransport.create!(name:'Carga Pesada', minimum_distance: 0, maximum_distance: 2000, 
                                       minimum_weight: 6000, maximum_weight: 30000, flat_rate: 950, status: :active)     
PriceByWeight.create!(minimum_weight: 6000, maximum_weight: 12000, value: 130, mode_of_transport: carga_pesada)
PriceByWeight.create!(minimum_weight: 12001, maximum_weight: 18000, value: 190, mode_of_transport: carga_pesada)
PriceByWeight.create!(minimum_weight: 18001, maximum_weight: 24000, value: 250, mode_of_transport: carga_pesada)
PriceByWeight.create!(minimum_weight: 24001, maximum_weight: 30000, value: 310, mode_of_transport: carga_pesada)
PricePerDistance.create!(minimum_distance: 0, maximum_distance: 400, rate: 460, mode_of_transport: carga_pesada)
PricePerDistance.create!(minimum_distance: 401, maximum_distance: 800, rate: 1000, mode_of_transport: carga_pesada)
PricePerDistance.create!(minimum_distance: 801, maximum_distance: 1200, rate: 1200, mode_of_transport: carga_pesada)
PricePerDistance.create!(minimum_distance: 1201, maximum_distance: 1600, rate: 1450, mode_of_transport: carga_pesada)
PricePerDistance.create!(minimum_distance: 1601, maximum_distance: 2000, rate: 1595, mode_of_transport: carga_pesada)
Deadline.create!(minimum_distance: 0, maximum_distance: 670, estimated_time: 168, mode_of_transport: carga_pesada)
Deadline.create!(minimum_distance: 671, maximum_distance: 1300, estimated_time: 336, mode_of_transport: carga_pesada)
Deadline.create!(minimum_distance: 1301, maximum_distance: 2000, estimated_time: 504, mode_of_transport: carga_pesada)

fretamax = ModeOfTransport.create!(name:'Fretamax', minimum_distance: 1000, maximum_distance: 2500, 
                                   minimum_weight: 200, maximum_weight: 1450, flat_rate: 600, status: :active)     
PriceByWeight.create!(minimum_weight: 200, maximum_weight: 620, value: 35, mode_of_transport: fretamax)
PriceByWeight.create!(minimum_weight: 621, maximum_weight: 960, value: 60, mode_of_transport: fretamax)
PriceByWeight.create!(minimum_weight: 961, maximum_weight: 1200, value: 85, mode_of_transport: fretamax)
PriceByWeight.create!(minimum_weight: 1201, maximum_weight: 1450, value: 110, mode_of_transport: fretamax)
PricePerDistance.create!(minimum_distance: 1000, maximum_distance: 1400, rate: 250, mode_of_transport: fretamax)
PricePerDistance.create!(minimum_distance: 1401, maximum_distance: 1800, rate: 400, mode_of_transport: fretamax)
PricePerDistance.create!(minimum_distance: 1801, maximum_distance: 2200, rate: 550, mode_of_transport: fretamax)
PricePerDistance.create!(minimum_distance: 2201, maximum_distance: 2500, rate: 700, mode_of_transport: fretamax)
Deadline.create!(minimum_distance: 1000, maximum_distance: 1200, estimated_time: 96, mode_of_transport: fretamax)
Deadline.create!(minimum_distance: 1201, maximum_distance: 1700, estimated_time: 144, mode_of_transport: fretamax)
Deadline.create!(minimum_distance: 1701, maximum_distance: 2100, estimated_time: 192, mode_of_transport: fretamax)
Deadline.create!(minimum_distance: 2101, maximum_distance: 2500, estimated_time: 240, mode_of_transport: fretamax)

User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')
User.create!(name: 'Janete de Jesus', email: 'janete@sistemadefrete.com.br', password: 'pass1234')
User.create!(name: 'Lara Machado', email: 'lara@sistemadefrete.com.br', password: 'pass1234', role: :admin)
User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: :admin)
User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: :admin)
 
vehicle = Vehicle.create!(nameplate: 'HPK3528', brand: 'Ford', model: 'Cargo 2428 E', year_of_manufacture: '2011',
                          maximum_capacity: 23000)
vehicle_2= Vehicle.create!(nameplate: 'AKL7566', brand: 'Mercedez Benz', model: 'ATEGO 1315', year_of_manufacture: '2014',
                           maximum_capacity: 13000)
vehicle_3 = Vehicle.create!(nameplate: 'KER0414', brand: 'Volks', model: 'Constelallation 17.250', year_of_manufacture: '2012',
                            maximum_capacity: 16000)                  
vehicle_4 = Vehicle.create!(nameplate: 'ISX8398', brand: 'Mercedez Benz', model: '710 PLUS', year_of_manufacture: '2020',
                            maximum_capacity: 6700)
vehicle_5 = Vehicle.create!(nameplate: 'LON3232', brand: 'Fiat', model: 'Doblò Cargo', year_of_manufacture: '2019',
                            maximum_capacity: 3200)
vehicle_6 = Vehicle.create!(nameplate: 'JNR6542', brand: 'Peugeot', model: 'Boxer', year_of_manufacture: '2022',
                            maximum_capacity: 1667)
Vehicle.create!(nameplate: 'JYE1885', brand: 'Fiat', model: 'Ducato', year_of_manufacture: '2016',
                maximum_capacity: 1670)
Vehicle.create!(nameplate: 'GWP3017', brand: 'Mercedez Benz', model: 'Sprinter', year_of_manufacture: '2014',
                maximum_capacity: 2030)
Vehicle.create!(nameplate: 'FIB5784', brand: 'Renault', model: 'Master', year_of_manufacture: '2018',
                maximum_capacity: 1593)
Vehicle.create!(nameplate: 'HVX2781', brand: 'Citroen', model: 'Jumpy', year_of_manufacture: '2019',
                maximum_capacity: 1500)
Vehicle.create!(nameplate: 'HYS1253', brand: 'Hyundai', model: 'HD 80', year_of_manufacture: '2015',
                maximum_capacity: 5260)
Vehicle.create!(nameplate: 'LRT7647', brand: 'Volkswagen', model: 'Delivery', year_of_manufacture: '2017',
                maximum_capacity: 5500)
Vehicle.create!(nameplate: 'LVN8395', brand: 'Foton', model: 'Minitruck 3.5', year_of_manufacture: '2020',
                maximum_capacity: 1450)
Vehicle.create!(nameplate: 'MZO8660', brand: 'Volvo', model: 'FH 540', year_of_manufacture: '2016',
                maximum_capacity: 57000)
Vehicle.create!(nameplate: 'HQZ9585', brand: 'Volvo', model: 'VM 310', year_of_manufacture: '2016', 
                maximum_capacity: 17500, status: :in_maintenance)
Vehicle.create!(nameplate: 'HUX6583', brand: 'Renault', model: 'Master', year_of_manufacture: '2015', 
                maximum_capacity: 3500, status: :in_maintenance)
Vehicle.create!(nameplate: 'JZZ2991', brand: 'Iveco', model: 'Tector 170 E 25', year_of_manufacture: '2012', 
                maximum_capacity: 17000, status: :in_maintenance)
Vehicle.create!(nameplate: 'IOC0693', brand: 'KIA', model: 'BONGO K 2500', year_of_manufacture: '2015', 
                maximum_capacity: 3400, status: :in_maintenance)
Vehicle.create!(nameplate: 'HBA6440', brand: 'Peugeot', model: 'Partner', year_of_manufacture: '2017',
                  maximum_capacity: 3000)
Vehicle.create!(nameplate: 'MXN9061', brand: 'Renault', model: 'Kangoo ZE Maxi', year_of_manufacture: '2018',
                  maximum_capacity: 3000)

ServiceOrder.create!(source_address: 'Avenida Getúlio Vargas, 250 | Feira de Santana - BA', product_code: 'MDKSJ-CADGM-ASM24',
                     height: 120, width: 65, depth: 70, weight: 12, destination_address: 'Avenida São Rafael, 478 | Salvador - BA',
                     recipient: 'Joana Matos', recipient_phone: '71999284839', total_distance: 100)
ServiceOrder.create!(source_address: 'Rua José Pacheco, 25 | Maranguape - CE', product_code: 'MDKSJ-RACKH-ASM24',
                     height: 50, width: 120, depth: 40, weight: 8, destination_address: 'Rua Beatriz, 57 | Fortaleza - CE',
                     recipient: 'Joana Matos', recipient_phone: '85999284839', total_distance: 30)
ServiceOrder.create!(source_address: 'Rua Antenor Dias, 110 | Jataí - GO', product_code: 'SBDNF-PAANS-SHFMD',
                     height: 87, width: 135, depth: 38, weight: 52, destination_address: 'Avenida A, 65 | Rio Grande - RS',
                     recipient: 'Maurício Peixoto', recipient_phone: '53933204958', total_distance: 1750)
ServiceOrder.create!(source_address: 'QE 11 Área Especial C, 12 | Brasília - DF ', product_code: 'SMDKE-DLSME-WPDOS',
                     height: 300, width: 250, depth: 300, weight: 10000, destination_address: 'Avenida Governador José Malcher, 327 | Belém - PA',
                     recipient: 'Janete Garcia', recipient_phone: '91993470058', total_distance: 1960)                     
ServiceOrder.create!(source_address: 'Travessa Antônio Ferreira, 980 | Capanema - PA', product_code: 'AANDM-OEHFM-SLDMF',
                     height: 390, width: 248, depth: 383, weight: 3200, destination_address: 'Avenida Afonso Pena, 1029 | Belo Horizonte - MG',
                     recipient: 'Sofia dos Santos', recipient_phone: '31999483042', total_distance: 1615)
ServiceOrder.create!(source_address: 'Rodovia Raposo Tavares, 384 | Cotia - SP', product_code: 'AKSMD-EEIFK-DLSOD',
                     height: 120, width: 78, depth: 45, weight: 30, destination_address: 'Rua Barão de Vitória, 293 | Diadema - SP',
                     recipient: 'Amanda Gonçalves', recipient_phone: '1133459203', total_distance: 47)
ServiceOrder.create!(source_address: 'Rua Santa Maria, 7354 | Rio Branco - AC', product_code: 'MMAPS-WISMD-LEMDH',
                     height: 380, width: 308, depth: 240, weight: 24000, destination_address: 'Avenida São Jorge, 9707 | Araraquara - SP',
                     recipient: 'Luiza Gomes', recipient_phone: '11991218343', total_distance: 3225)
ServiceOrder.create!(source_address: 'Praça da República, 100 | São Paulo - SP', product_code: 'APPER-PWLSO-EEHXT',
                     height: 30, width: 90, depth: 28, weight: 15, destination_address: 'Rua das Fiandeiras, 370 | São Paulo - SP',
                     recipient: 'Fernando Queiroz', recipient_phone: '11990124892', total_distance: 10)          

service_order = ServiceOrder.create!(source_address: 'Avenida Tocantins, 384 | Jataí - GO', product_code: 'SBDNF-PRIFM-SHFMD',
                                     height: 87, width: 135, depth: 38, weight: 55, destination_address: 'Zona Portuária, 30 - Rio Grande',
                                     recipient: 'Maurício Peixoto', recipient_phone: '53933204958', total_distance: 1730,
                                     mode_of_transport: economica, vehicle: vehicle, started_in: 3.week.ago, status: :in_progress)
service_order.register_price_and_deadline  
vehicle.on_delivery!

service_order_2 = ServiceOrder.create!(source_address: 'Avenida Esbertalina Barbosa Damiani, 85 | São Mateus - ES', product_code: 'AMROS-SMDNT-EPSLD',
                                       height: 200, width: 80, depth: 3, weight: 4, destination_address: 'Rua Tenente Coronel Cardoso, 264 | Campos dos Goytacazes - RJ',
                                       recipient: 'Flávia Andrade', recipient_phone: '22996573849', total_distance: 510, 
                                       mode_of_transport: via_cargas, vehicle: vehicle_2, started_in: 5.days.ago, status: :in_progress)
service_order_2.register_price_and_deadline  
vehicle_2.on_delivery!

service_order_3 = ServiceOrder.create!(source_address: 'Rua Paracatu, 957 | São Paulo - SP', product_code: 'AMDNF-EOLDF-SHNFK',
                                       height: 70, width: 40, depth: 30, weight: 2, destination_address: 'Rua da Imprensa, 48 | Gramado - RS',
                                       recipient: 'João Cerqueira', recipient_phone: '54988475495', total_distance: 1120, started_in: 1.day.ago,
                                       closed_in: 3.hours.ago, mode_of_transport: express, vehicle: vehicle_3, status: :closed_on_deadline)       
service_order_3.register_price_and_deadline                  

service_order_4 = ServiceOrder.create!(source_address: 'Avenida Abel Cabral, 253 | Parnamirim - RN', product_code: 'BHTSP-MEPDR-RIELS',
                                       height: 100, width: 280, depth: 40, weight: 20, destination_address: 'Travessa Jerusalém, 150 | Aracaju - SE',
                                       recipient: 'Márcio Lopes', recipient_phone: '7991748823', total_distance: 775, started_in: 15.days.ago,
                                       closed_in: 5.days.ago, mode_of_transport: economica, vehicle: vehicle_4, status: :closed_in_arrears)
service_order_4.register_price_and_deadline  
overdue_reason = OverdueReason.create!(overdue_reason: 'Falhas na comunicação com o motorista', service_order: service_order_4)      
service_order_4.overdue_reason = overdue_reason

service_order_5 = ServiceOrder.create!(source_address: 'Rua Carlos Augusto Cornelsen, 127 | Curitiba - PR', product_code: 'XMSOD-EIRUE-ALWED',
                                       height: 220, width: 288, depth: 150, weight: 19, destination_address: 'Rua Pereira Estéfano, 2930 | São Paulo - SP',
                                       recipient: 'Dante Sila', recipient_phone: '11987220588', total_distance: 405, started_in: 5.hours.ago,
                                       mode_of_transport: transitar, vehicle: vehicle_5, status: :in_progress)
service_order_5.register_price_and_deadline  
vehicle_5.on_delivery!                                   

service_order_6 = ServiceOrder.create!(source_address: 'Avenida Castelo Branco, 1220 | Blumenau - SC', product_code: 'AKSMD-EEIFK-DLSOD',
                                       height: 120, width: 78, depth: 45, weight: 30, destination_address: 'Travessa Santa Rita, 947 | Parnaíba - PI',
                                       recipient: 'Jeniffer Nascimento', recipient_phone: '86990394855', total_distance: 3553, started_in: 45.days.ago,
                                       mode_of_transport: economica, vehicle: vehicle_3, status: :in_progress)
service_order_6.register_price_and_deadline  
vehicle_3.on_delivery!                                                         

service_order_7 = ServiceOrder.create!(source_address: 'Avenida Almirante Maximiano Fonseca, 99 | Rio Grande - RS', product_code: 'GMNBE-LLGXP-AAHTR',
                                       height: 75, width: 128, depth: 60, weight: 50, destination_address: 'Rua Bromélias, 750 | Rio de Janeiro - RJ',
                                       recipient: 'Evelyn Silveira', recipient_phone: '21992213356', total_distance: 1790, started_in: 10.days.ago, 
                                       mode_of_transport: disk_envios, vehicle: vehicle_4, closed_in: 5.days.ago, status: :closed_on_deadline)
service_order_7.register_price_and_deadline  

service_order_8 = ServiceOrder.create!(source_address: 'Rua Frederico Moura, 999 | Franca - SP', product_code: 'CMSJD-WLDOS-NDJSL',
                                       height: 200, width: 150, depth: 100, weight: 450, destination_address: 'Rua Arlindo Nogueira, 238 | Teresina - PI',
                                       recipient: 'Pedro Ferreira', recipient_phone: '86994738443', total_distance: 2300, started_in: 20.days.ago,
                                       mode_of_transport: fretamax, vehicle: vehicle_6, closed_in: 11.days.ago, status: :closed_on_deadline)
service_order_8.register_price_and_deadline  