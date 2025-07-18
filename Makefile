# This Makefile provides commands to manage a PostgreSQL database for a simple bank application.

postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=olleon31 -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres12 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:olleon31@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:olleon31@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc: 
	sqlc generate

.PHONY: createdb dropdb postgres migrateup migratedown sqlc

