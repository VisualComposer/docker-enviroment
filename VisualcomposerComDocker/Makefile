include docker.mk
include project.mk

# set project files
setprojectfilesrepository:
	# create folder and populate it with project files
	git clone $(PROJECT_GIT_REPOSITORY) ../$(PROJECT_FOLDER)
	git submodule init ../$(PROJECT_FOLDER)
	git submodule update ../$(PROJECT_FOLDER)
setprojectfilesconfiguration:
	cp .htaccess-docker ../$(PROJECT_FOLDER)/.htaccess
	cp wp-config.php ../$(PROJECT_FOLDER)/wp-config.php
# import database from production server to local server
dbfromhosttolocal:
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
		mysqldump --lock-tables=false -u$(PROJECT_DEV_DB_USER) -p'$(PROJECT_DEV_DB_PASS)' -h$(PROJECT_DEV_DB_HOST) $(PROJECT_DEV_DB_NAME) > foo.sql"
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
		mysql -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) -e 'DROP database IF EXISTS $(DB_NAME); CREATE database $(DB_NAME);' && \
		mysql -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) $(DB_NAME) < foo.sql && \
		mysql -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) -e \"USE $(DB_NAME); UPDATE $(DB_PREFIX)users SET user_pass = '$$\P$$\BsE6UdrjNmFizCg4v5lW1r4jNLmaQ3\/' WHERE user_login = 'jelagum';\""
	rm -rf ./../$(PROJECT_FOLDER)/foo.sql
# import database from local server to test server
dbfromlocaltotest:
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
		mysqldump -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) $(DB_NAME) > ./foo.sql && \
		mysql -u$(PROJECT_TEST_DB_USER) -p'$(PROJECT_TEST_DB_PASS)' -h$(PROJECT_TEST_DB_HOST) $(PROJECT_TEST_DB_NAME) < ./foo.sql && \
		mysql -u$(PROJECT_TEST_DB_USER) -p'$(PROJECT_TEST_DB_PASS)' -h$(PROJECT_TEST_DB_HOST) -e \"USE $(PROJECT_TEST_DB_NAME); UPDATE $(DB_PREFIX)users SET user_pass = '$$\P$$\BsE6UdrjNmFizCg4v5lW1r4jNLmaQ3\/' WHERE user_login = 'jelagum';\""
	rm -rf ./../$(PROJECT_FOLDER)/foo.sql
# import database from test server to local server
dbfromtesttolocal:
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
		mysqldump --lock-tables=false -u$(PROJECT_TEST_DB_USER) -p'$(PROJECT_TEST_DB_PASS)' -h$(PROJECT_TEST_DB_HOST) $(PROJECT_TEST_DB_NAME) > foo.sql"
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
	mysql -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) -e 'DROP database IF EXISTS $(DB_NAME); CREATE database $(DB_NAME);' && \
	mysql -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) $(DB_NAME) < foo.sql && \
	mysql -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) -e \"USE $(DB_NAME); UPDATE $(DB_PREFIX)users SET user_pass = '$$\P$$\BsE6UdrjNmFizCg4v5lW1r4jNLmaQ3\/' WHERE user_login = 'jelagum';\""
	rm -rf ./../$(PROJECT_FOLDER)/foo.sql
# import database from local server to production server
dbfromlocaltohost:
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
		mysqldump -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) $(DB_NAME) > ./foo.sql && \
		mysql -u$(PROJECT_DEV_DB_USER) -p'$(PROJECT_DEV_DB_PASS)' -h$(PROJECT_DEV_DB_HOST) $(PROJECT_DEV_DB_NAME) < ./foo.sql && \
		mysql -u$(PROJECT_DEV_DB_USER) -p'$(PROJECT_DEV_DB_PASS)' -h$(PROJECT_DEV_DB_HOST) -e \"USE $(PROJECT_DEV_DB_NAME); UPDATE $(DB_PREFIX)users SET user_pass = '$$\P$$\BsE6UdrjNmFizCg4v5lW1r4jNLmaQ3\/' WHERE user_login = 'jelagum';\""
	rm -rf ./../$(PROJECT_FOLDER)/foo.sql
dbsshfromhosttolocal:
	ssh $(SSH_CONNECT) "mysqldump --lock-tables=false -hlocalhost -u$(PROJECT_DEV_SSH_DB_USER) -p'$(PROJECT_DEV_SSH_DB_PASS)' $(PROJECT_DEV_SSH_DB_NAME)" > ./../$(PROJECT_FOLDER)/foo.sql
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
		mysql -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) -e 'DROP database IF EXISTS $(DB_NAME); CREATE database $(DB_NAME);' && \
		mysql -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) $(DB_NAME) < foo.sql && \
		mysql -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) -e \"USE $(DB_NAME); UPDATE $(DB_PREFIX)users SET user_pass = '$$\P$$\BsE6UdrjNmFizCg4v5lW1r4jNLmaQ3\/' WHERE user_login = 'jelagum';\""
	rm -rf ./../$(PROJECT_FOLDER)/foo.sql
dbsshfromtesttolocal:
	ssh $(SSH_CONNECT) "mysqldump --lock-tables=false -hlocalhost -u$(PROJECT_TEST_SSH_DB_USER) -p'$(PROJECT_TEST_SSH_DB_PASS)' $(PROJECT_TEST_SSH_DB_NAME)" > ./../$(PROJECT_FOLDER)/foo.sql
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
		mysql -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) -e 'DROP database IF EXISTS $(DB_NAME); CREATE database $(DB_NAME);' && \
		mysql -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) $(DB_NAME) < foo.sql && \
		mysql -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) -e \"USE $(DB_NAME); UPDATE $(DB_PREFIX)users SET user_pass = '$$\P$$\BsE6UdrjNmFizCg4v5lW1r4jNLmaQ3\/' WHERE user_login = 'jelagum';\""
	rm -rf ./../$(PROJECT_FOLDER)/foo.sql
dbsavedate:
	rm -rf mariadb-init/*
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
		mysqldump -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) $(DB_NAME) > ./\"$$(date +''%d%m%Y'.sql')\" "
	mv ../$(PROJECT_FOLDER)/"$$(date +''%d%m%Y'.sql')" mariadb-init
dbsave:
	rm -rf mariadb-init/*
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
		mysqldump -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) $(DB_NAME) > ./init.sql"
	mv ./../$(PROJECT_FOLDER)/init.sql mariadb-init
dbmycli:
	mycli -h127.0.0.1 -uwordpress -pwordpress -P$(PROJECT_PORT_DB) $(DB_NAME)
# update db user or create one
dbupdateuser:
	php ../../Control/Scripts/control.php 'Wordpress_Database_Interaction' '{"request":"update_user", "DB_NAME":"$(DB_NAME)", "DB_PREFIX":"$(DB_PREFIX)", "DB_USER":"$(DB_USER)", "DB_PASSWORD":"$(DB_PASSWORD)", "DB_HOST":"$(DB_HOST)", "PROJECT_NAME":"$(PROJECT_NAME)", "DB_ADMIN_LOGIN":"$(DB_ADMIN_LOGIN)", "DB_ADMIN_PASSWORD":"$(DB_ADMIN_PASSWORD)", "DB_ADMIN_PASSWORD_HASH":"$(DB_ADMIN_PASSWORD_HASH)", "DB_ADMIN_MAIL":"$(DB_ADMIN_MAIL)" }'
# create project current version backup
backupcreate:
	php ../../Control/Scripts/control.php 'Wordpress_Backup' '{"PROJECT_FOLDER":"$(PROJECT_FOLDER)", "PROJECT_BASE_FOLDER":"$(PROJECT_BASE_FOLDER)", "DB_NAME":"$(DB_NAME)", "DB_USER":"$(DB_USER)", "DB_PASSWORD":"$(DB_PASSWORD)", "DB_HOST":"$(DB_HOST)", "PROJECT_NAME":"$(PROJECT_NAME)" }'
# create project current version backup
backuplist:
	php ../../Control/Scripts/control.php 'Wordpress_Backup_List' '{"PROJECT_FOLDER":"$(PROJECT_FOLDER)", "PROJECT_BASE_FOLDER":"$(PROJECT_BASE_FOLDER)", "DB_NAME":"$(DB_NAME)", "DB_USER":"$(DB_USER)", "DB_PASSWORD":"$(DB_PASSWORD)", "DB_HOST":"$(DB_HOST)", "PROJECT_NAME":"$(PROJECT_NAME)" }'
# backuprestore:
# 	php ../../Control/Scripts/control.php 'Wordpress_Backup_Restore' '{"PROJECT_FOLDER":"$(PROJECT_FOLDER)", "PROJECT_BASE_FOLDER":"$(PROJECT_BASE_FOLDER)", "DB_NAME":"$(DB_NAME)", "DB_USER":"$(DB_USER)", "DB_PASSWORD":"$(DB_PASSWORD)", "DB_HOST":"$(DB_HOST)", "PROJECT_NAME":"$(PROJECT_NAME)" }'
ssh:
	ssh $(SSH_CONNECT)
