# README | Sistema de frete

## Conteúdos
  * [O Projeto](#o-projeto)
  * [Passo a passo para rodar a app](#passo-a-passo-para-rodar-a-app)
  * [Contas sugeridas para testar a app](#contas-sugeridas-para-testar-a-app)
  * [Comando para rodar os testes](#comando-para-rodar-os-testes)
  * [Comando para detectar ofensas](#comando-para-detectar-ofensas)
  * [Configurações necessárias](#configurações-necessárias)
  * [Gems instaladas](#gems-instaladas)
  
## O Projeto

<p align = "justify"> Sistema de Frete desenvolvido em Ruby on Rails utilizando TDD. Desafio da 1ª etapa do treinamento do TreinaDev Delas. </p>

![Imagem de demonstração](https://github.com/Thalis-Freitas/freight-system/blob/59760da00fd07294dcd5bf7a64932925e3b7dfe8/app/assets/images/imagem-demonstra%C3%A7%C3%A3o.jpeg)

## Passo a passo para rodar a app

<p align = "justify"> 1 - Clone o projeto: </p>

```
$ git clone git@github.com:Thalis-Freitas/freight-system.git
```

<p align = "justify"> 2 - Entre na pasta do projeto: </p>

```
$ cd freight-system
```

<p align = "justify"> 3 - Instale as dependências: </p>

```
$ bin/setup
```

<p align = "justify"> 4 - Execute as migrations: </p>

```
$ rails db:migrate
```

<p align = "justify"> 5 - Popule a aplicação com seeds: </p>

```
$ rails db:seed
```

<p align = "justify"> 6 - Suba o servidor: </p>

```
$ rails s
```

* Acesse http://localhost:3000/

## Contas sugeridas para testar a app:

* Usuário regular: 

e-mail: daiane_silva@sistemadefrete.com.br

senha: senha123

* Admin: 

e-mail: marta@sistemadefrete.com.br 

senha: password

## Comando para rodar os testes

```
$ rspec
```

## Comando para detectar ofensas

```
$ rubocop
```

## Configurações necessárias

- [Ruby](https://ruby-doc.org/core-3.1.2/): `3.1.2`

- [Rails](https://rubyonrails.org/index.html): `7.0.4`

- [NodeJS](https://nodejs.org/en/): `18.12.0`

- [Yarn](https://classic.yarnpkg.com/lang/en/docs/): `1.22.19`

## Gems instaladas

- [rspec-rails](https://rspec.info/)
- [capybara](https://rubydoc.info/github/teamcapybara/capybara)
- [devise](https://github.com/heartcombo/devise)
- [rubocop](https://github.com/rubocop/rubocop)
- [simplecov](https://github.com/simplecov-ruby/simplecov)
- [bootstrap](https://getbootstrap.com/)
 
