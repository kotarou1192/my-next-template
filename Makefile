build-prod:
	docker-compose build

run-prod:
	docker-compose up --build -d

stop-prod:
	docker-compose down

run-dev:
	docker-compose -f docker-compose.dev.yml up -d --build

stop-dev:
	docker-compose -f docker-compose.dev.yml down
