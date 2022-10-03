updatemain:
	cd ../$(PROJECT_FOLDER_PLUGIN); git checkout master; git pull upstream master; git pull; git push; git push origin master; php ci/composer.phar update; git fetch -p; git fetch --all --tags; bash tools/elements/buildScript.sh
updateelements:
	cd ../$(PROJECT_FOLDER_PLUGIN)/devElements; git checkout master; git pull; git pull origin master
updateaddons:
	cd ../$(PROJECT_FOLDER_PLUGIN)/devAddons; git checkout master; git pull; git pull origin master
updateall:
	make updatemain
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
	cd ../$(PROJECT_FOLDER_PLUGIN); git remote add upstream git@github.com:VisualComposer/builder.git; git remote set-url --push upstream no_push; yarn install --ignore-engines; yarn build; php ci/composer.phar update; bash tools/elements/buildScript.sh; cp backend/env-dev.php ../$(PROJECT_FOLDER)/wp-content/plugins/builder
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
	cp backend/main.cypress.env.json ../$(PROJECT_FOLDER)/wp-content/plugins/builder/tests/cypressChrome/cypress.env.json
	cp backend/main.cypress.env.json ../$(PROJECT_FOLDER)/wp-content/plugins/builder/tests/cypressElectron/cypress.env.json
sete2econfigurationelements:
	cp backend/element.cypress.env.json ../$(PROJECT_FOLDER)/wp-content/plugins/builder/devElements/_tests/cypress.json
	cp backend/element.index.js ../$(PROJECT_FOLDER)/wp-content/plugins/builder/devElements/_tests/cypress/support/index.js
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
resetprojectwithpluginactivateandthemeactivate:
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_php' --format "{{ .ID }}") sh -c "\
		wp db reset --yes; wp core install --url=http://localhost/Dev/Wordpress/Test4Ru/WordpressDev/ --title='Example' --admin_user=jelagum --admin_password='rM)i[K~PetI6' --admin_email=dollar4444@gmail.com; wp plugin activate builder; wp theme install visual-composer-starter; wp theme activate visual-composer-starter"
