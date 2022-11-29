# README | Sistema de frete

## Conteúdos
  * [O Projeto](#o-projeto)
  * [Passo a passo para rodar a app](#passo-a-passo-para-rodar-a-app)
  * [Contas sugeridas para testar a app](#contas-sugeridas-para-testar-a-app)
  * [Comando para rodar os testes](#comando-para-rodar-os-testes)
  * [Mais informações](#mais-informações)
  

## O Projeto

<p align = "justify"> Sistema de Frete desenvolvido em Ruby on Rails utilizando TDD. Desafio da 1ª etapa do treinamento do TreinaDev Delas. </p>

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

## Mais informações

* Versão Ruby: `3.1.2`

* Versão Rails: `7.0.4`

* Gems utilizadas para configurar o ambiente de testes: `rspec-rails` e `capybara`

* Gem utilizada para autenticação: `devise`
 
