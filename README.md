## Objetivo
API REST de carrinho de compras para case técnico.

## Stack
Ruby 3.3.1, Rails 7.1, PostgreSQL, Redis, Sidekiq, RSpec.

## Rodando local
1. bundle install
2. rails db:prepare
3. bundle exec sidekiq
4. bundle exec rails s

## Rodando com Docker
docker compose up --build
docker compose run --rm test

## Endpoints
POST /cart
POST /cart/add_item
GET /cart
DELETE /cart/:product_id
CRUD /products

## Regras implementadas
- carrinho por sessão
- validação de quantidade > 0
- marca abandono em 3h
- remove abandonados > 7 dias

## Melhorias futuras
- autenticação no /sidekiq
- testes de integração adicionais
- padronização de erros