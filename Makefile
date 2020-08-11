DATA=$(shell date +%Y-%m-%d)

dev:
	docker-compose up -d

clean:
	docker-compose down
	docker volume ls -qf dangling=true | xargs -r docker volume rm

enter-php:
	docker exec -it simple-php72 bash

import-db:
	ssh root@142.93.32.110 "dumpdb"
	rsync -Oazv --progress root@142.93.32.110:/tmp/dumps/chatbot-${DATA}.sql.gz ${PWD}/db
	ssh root@142.93.32.110 "rm -rf /tmp/dumps/chatbot-${DATA}.sql.gz"
	docker exec -i simplechat-mysql mysql -h localhost -u root -psimplechat -e "DROP DATABASE IF EXISTS simplechat"
	docker exec -i simplechat-mysql mysql -h localhost -u root -psimplechat -e "CREATE DATABASE IF NOT EXISTS simplechat"
	gunzip <  ${PWD}/db/chatbot-${DATA}.sql.gz | docker exec -i simplechat-mysql mysql -h localhost -u root -psimplechat simplechat
	docker exec -i simplechat-mysql mysql -h localhost -u root -psimplechat simplechat -e "update users set password = '$2y$10$MgasMZr4GODDHGy2Zk7JQOLNtgtZcTt.EL2gbtqTOd4mNFNBaNn16' WHERE email = 'borsatti.dev@gmail.com'"

restore-db:
	rsync -Oazv --progress burp@178.62.75.116:/home/burp/chatbot-2020-03-23-06-01.sql.gz ${PWD}/db
	ssh burp@178.62.75.116 "rm -rf /home/burp/chatbot-2020-03-23-06-01.sql.gz"
	docker exec -i simplechat-mysql mysql -h localhost -u root -psimplechat -e "DROP DATABASE IF EXISTS simplechat"
	docker exec -i simplechat-mysql mysql -h localhost -u root -psimplechat -e "CREATE DATABASE IF NOT EXISTS simplechat"
	gunzip <  ${PWD}/db/chatbot-2020-03-23-06-01.sql.gz | docker exec -i simplechat-mysql mysql -h localhost -u root -psimplechat simplechat

