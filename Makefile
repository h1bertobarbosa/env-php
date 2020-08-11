DATA=$(shell date +%Y-%m-%d)

dev:
	docker-compose up -d

clean:
	docker-compose down
	docker volume ls -qf dangling=true | xargs -r docker volume rm

enter-php:
	docker exec -it php73 bash

