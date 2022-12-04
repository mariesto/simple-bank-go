DB_URL=postgresql://root:gogogo@localhost:5432/simple_bank?sslmode=disable

run-postgres:
	docker run --name simple-bank-container -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=gogogo -d postgres:12.13

create-db:
	docker exec -it simple-bank-container createdb --username=root --owner=root simple_bank

drop-db:
	docker exec -it postgres:12.13 dropdb simple_bank

migrate-up:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migrate-down:
	migrate -path db/migration -database "$(DB_URL)" -verbose down

sqlc-generate:
	sqlc generate

.PHONY: run-postgres create-db drop-db migrate-up migrate-down sqlc-generate