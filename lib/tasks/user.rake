namespace :user do
  desc "Popular a tabela users"
  if Rails.env.development?
    task set_users: :environment do
      User.create!(name: 'Daiane Silva', email: 'daiane_silva@sistemadefrete.com.br', password: 'senha123')
      User.create!(name: 'Marcus Lima', email: 'marcus_lima@sistemadefrete.com.br', password: 'senha123')
      User.create!(name: 'Marcelo Costa', email: 'marcelo@sistemadefrete.com.br', password: 'pass1234')
      User.create!(name: 'Janete de Jesus', email: 'janete@sistemadefrete.com.br', password: 'pass1234')
      User.create!(name: 'Lara Machado', email: 'lara@sistemadefrete.com.br', password: 'pass1234', role: 'admin')
      User.create!(name: 'Marta Alves', email: 'marta@sistemadefrete.com.br', password: 'password', role: 'admin')
      User.create!(name: 'Luís dos Santos', email: 'luis_s@sistemadefrete.com.br', password: 'password', role: 'admin')
    end
  else
    puts 'Ops, você não está no ambiente de desenvolvimento'
  end
end