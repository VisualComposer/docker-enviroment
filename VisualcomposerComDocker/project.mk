updatemain:
	cd ../$(PROJECT_FOLDER_PLUGIN); git checkout master; git pull upstream master; git pull; git push; git push origin master; php ci/composer.phar update; git fetch -p; git fetch --all --tags;
updatemainassets:
	cd ../$(PROJECT_FOLDER_PLUGIN); bash tools/elements/buildScript.sh; rm -rf node_modules; yarn install; yarn build;
updateelements:
	cd ../$(PROJECT_FOLDER_PLUGIN)/devElements; git checkout master; git pull; git pull origin master
updateaddons:
	cd ../$(PROJECT_FOLDER_PLUGIN)/devAddons; git checkout master; git pull; git pull origin master
updateallrepose:
	make updatemain
	make updateelements
	make updateaddons
updateallwithassets:
	make updatemain
	make updatemainassets
	make updateelements
	make updateaddons
updatephp:
	cd ../$(PROJECT_FOLDER_PLUGIN); php ci/composer.phar update
checkcodestandardphpmain:
	cd ../$(PROJECT_FOLDER_PLUGIN); php ci/vendor/bin/phpcs --standard=ci/ruleset.xml plugin-wordpress.php bootstrap visualcomposer/Framework visualcomposer/Helpers visualcomposer/Modules visualcomposer/Application.php visualcomposer/Requirements.php
checkcodestandardjsmain:
	cd ../$(PROJECT_FOLDER_PLUGIN); yarn lint "public/**/*.js"
checkcodestandardjselements:
	cd ../$(PROJECT_FOLDER_PLUGIN)/devElements; yarn eslint
checkcodestandardphpelements:
	cd ../$(PROJECT_FOLDER_PLUGIN); php devElements/.github/phpcs.phar --standard=devElements/.github/ruleset.xml devElements
checkcodestandardjsaddons:
	cd ../$(PROJECT_FOLDER_PLUGIN)/devAddons; yarn eslint
checkcodestandardphpaddons:
	cd ../$(PROJECT_FOLDER_PLUGIN); php devAddons/.github/phpcs.phar --standard=devAddons/.github/ruleset.xml devAddons
fixcodestandardphpmain:
	cd ../$(PROJECT_FOLDER_PLUGIN); ci/vendor/bin/phpcbf --standard=ci/ruleset.xml plugin-wordpress.php bootstrap visualcomposer/Framework visualcomposer/Helpers visualcomposer/Modules visualcomposer/Application.php visualcomposer/Requirements.php
fixcodestandardphpelements:
	cd ../$(PROJECT_FOLDER_PLUGIN); php ci/phpcbf.phar --standard=devElements/.github/ruleset.xml devElements
fixcodestandardphpaddons:
	cd ../$(PROJECT_FOLDER_PLUGIN); php ci/phpcbf.phar --standard=devAddons/.github/ruleset.xml devAddons
installmain:
	cd ../$(PROJECT_FOLDER_PLUGIN); git remote add upstream git@github.com:VisualComposer/builder.git; git remote set-url --push upstream no_push; yarn install --ignore-engines; yarn build; bash tools/elements/buildScript.sh; cp backend/env-dev.php ../$(PROJECT_FOLDER)/wp-content/plugins/builder; cd ci; php composer.phar install;
installelements:
	cd ../$(PROJECT_FOLDER_PLUGIN); git clone git@github.com:VisualComposer/devElements.git; cd devElements; cp env-dev.php ../; yarn install --ignore-engines; bash .hubtools/buildScript.sh
installaddons:
	cd ../$(PROJECT_FOLDER_PLUGIN); git clone git@github.com:VisualComposer/devAddons.git; cd devAddons; bash .hubtools/buildScript.sh
installpremium:
	make installelements
	make installaddons
setalltomaster:
	cd ../$(PROJECT_FOLDER_PLUGIN); pwd; git checkout master; cd devAddons; git checkout master; cd devElements; git checkout master
sete2econfigurationmain:
	cp backend/main.cypress.config.js ../$(PROJECT_FOLDER)/wp-content/plugins/builder/tests/cypressChrome/cypress.config.js
	cp backend/main.cypress.config.js ../$(PROJECT_FOLDER)/wp-content/plugins/builder/tests/cypressElectron/cypress.config.js
sete2econfigurationelements:
	cp backend/element.cypress.config.js ../$(PROJECT_FOLDER)/wp-content/plugins/builder/devElements/_tests/cypress.config.js
	cp backend/element.e2e.js ../$(PROJECT_FOLDER)/wp-content/plugins/builder/devElements/_tests/cypress/support/e2e.js
sete2econfigurationaddons:
	cp backend/addon.cypress.config.js ../$(PROJECT_FOLDER)/wp-content/plugins/builder/devAddons/tests/cypress.config.js
	cp backend/addon.e2e.js ../$(PROJECT_FOLDER)/wp-content/plugins/builder/devAddons/tests/cypress/support/e2e.js
	cp backend/addon.index.js ../$(PROJECT_FOLDER)/wp-content/plugins/builder/devAddons/tests/cypress/plugins/index.js
launchteste2emainconsole:
	make sete2econfigurationmain
	make resetprojectwithpluginactivateandthemeactivate
	cd ../$(PROJECT_FOLDER_PLUGIN); yarn run cypress run --project ./tests/cypressElectron
launchteste2emainbrowser:
	make sete2econfigurationmain
	make resetprojectwithpluginactivateandthemeactivate
	cd ../$(PROJECT_FOLDER_PLUGIN); yarn run cypress open --browser=chrome --project ./tests/cypressElectron/
launchteste2eelementsconsole:
	make sete2econfigurationelements
	make resetprojectwithpluginactivateandthemeactivate
	cd ../$(PROJECT_FOLDER_PLUGIN); yarn run cypress run --project ./devElements/_tests
launchteste2eelementsbrowser:
	make sete2econfigurationelements
	make resetprojectwithpluginactivateandthemeactivate
	cd ../$(PROJECT_FOLDER_PLUGIN); yarn run cypress open --browser=chrome --project ./devElements/_tests
launchteste2eaddonsconsole:
	make sete2econfigurationaddons
	make resetprojectwithpluginactivateandthemeactivate
	cd ../$(PROJECT_FOLDER_PLUGIN); yarn run cypress run --project ./devAddons/tests
launchteste2eaddonsbrowser:
	make sete2econfigurationaddons
	make resetprojectwithpluginactivateandthemeactivate
	cd ../$(PROJECT_FOLDER_PLUGIN); yarn run cypress open --browser=chrome --project ./devAddons/tests
createprodrealize:
	rm -rf ../$(PROJECT_FOLDER)/wp-content/plugins/visualcomposer.zip
	rm -rf ../$(PROJECT_FOLDER)/wp-content/plugins/visualcomposer
	cd ../$(PROJECT_FOLDER)/wp-content/plugins
	cp -r ../$(PROJECT_FOLDER)/wp-content/plugins/builder ../$(PROJECT_FOLDER)/wp-content/plugins/visualcomposer
	cd ../$(PROJECT_FOLDER)/wp-content/plugins/visualcomposer; rm -rf ci .circleci CODE_OF_CONDUCT.md composer.json composer.lock CONTRIBUTING.md devAddons devElements .editorconfig env-dev.php .git* hubtools _infrastructure node_modules package.json .phpstorm.meta.php .sonarcloud.properties tests tools webpack.config.babel.js webpack.config.production.babel.js;
	cd ../$(PROJECT_FOLDER)/wp-content/plugins/visualcomposer; zip -r visualcomposer.zip *
	mv ../$(PROJECT_FOLDER)/wp-content/plugins/visualcomposer/visualcomposer.zip ../$(PROJECT_FOLDER)/wp-content/plugins
	rm -rf ../$(PROJECT_FOLDER)/wp-content/plugins/visualcomposer
resetproject:
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
		wp db reset --yes; wp core install --url=http://localhost/Dev/Wordpress/Test4Ru/WordpressDev/ --title='Example' --admin_user=jelagum --admin_password='rM)i[K~PetI6' --admin_email=dollar4444@gmail.com"
resetprojectwithpluginactivate:
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
		wp db reset --yes; wp core install --url=http://localhost/Dev/Wordpress/Test4Ru/WordpressDev/ --title='Example' --admin_user=jelagum --admin_password='rM)i[K~PetI6' --admin_email=dollar4444@gmail.com; wp plugin activate builder"
	make setprojectfreelicense
resetprojectwithpluginactivateandthemeactivate:
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
		wp db reset --yes; wp core install --url=http://localhost/Dev/Wordpress/Test4Ru/WordpressDev/ --title='Example' --admin_user=jelagum --admin_password='rM)i[K~PetI6' --admin_email=dollar4444@gmail.com; wp plugin activate builder; wp theme install visual-composer-starter; wp theme activate visual-composer-starter"
	make setprojectfreelicense
setprojectfreelicense:
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
		mysql -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) -e \"USE $(DB_NAME); REPLACE INTO wp_options (option_name, option_value, autoload) VALUES ('vcv-license-key', 'a22712e4-db83-4e42-bf2a-24eb543ed08d', 'yes'); \""
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
		mysql -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) -e \"USE $(DB_NAME); REPLACE INTO wp_options (option_name, option_value, autoload)  VALUES ('vcv-license-type', 'free', 'yes'); \""
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
		mysql -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) -e \"USE $(DB_NAME); REPLACE INTO wp_options (option_name, option_value, autoload)  VALUES ('vcv-license-expiration', 'lifetime', 'yes'); \""
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
		mysql -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) -e \"USE $(DB_NAME); REPLACE INTO wp_options (option_name, option_value, autoload)  VALUES ('vcv-settings-initial-helpers-enabled', '', 'yes'); \""
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
		mysql -u$(DB_USER) -p'$(DB_PASSWORD)' -h$(DB_HOST) -e \"USE $(DB_NAME); REPLACE INTO wp_options (option_name, option_value, autoload)  VALUES ('vcv-settings-itemdatacollection-enabled', '', 'yes'); \""
