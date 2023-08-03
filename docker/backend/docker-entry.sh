#!/usr/bin/bash
# INSTALLING Magento2

FILE=composer.lock
ENV_FILE=app/etc/env.php
INSTALLATION_DIR=/var/www/html
SHOP_FILE=/var/www/html/vendor/anee/shopfinder/etc/module.xml
INSTALL_FILE=dev/tests/integration/etc/install-config-mysql.php

# changing memory_limit in php.ini
cp -rf /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
sed -i 's.memory_limit =.;memory_limit =.' /usr/local/etc/php/php.ini \
  && echo "memory_limit = 2G" >> /usr/local/etc/php/php.ini && echo "post_max_size = 800M" >> /usr/local/etc/php/php.ini &&
  echo "upload_max_filesize = 200M" >> /usr/local/etc/php/php.ini && echo "max_execution_time = 300" >> /usr/local/etc/php/php.ini &&
  echo "max_input_vars = 40000" >> /usr/local/etc/php/php.ini

function InstallComposerAndModuleMagento2() {
  echo "**********STARTING DownloadMagento2**********";
  if [[ ! -f $FILE ]]; then
    composer create-project --repository-url="${REPO}" magento/project-community-edition="${MAGENTO_VERSION}" "${INSTALLATION_DIR}"
    composer install
    composer require anee/shopfinder:1.0.0
  fi
}

function installMagentoProject() {
    echo "**********STARTING installMagentoProject**********";
   if [[ ! -f $SHOP_FILE ]]; then
     # Install extension shopfinder
     composer require anee/shopfinder
   fi
   php bin/magento setup:install \
       --base-url="${MAGENTO_URL}" \
       --backend-frontname="${BACKEND_FRONTNAME}" \
       --db-host="${REAL_DB_HOST}" \
       --db-name=${DB_NAME} \
       --db-user=${DB_USER} \
       --db-password=${DB_USER_PASSWORD} \
       --admin-firstname="${ADMIN_FIRSTNAME}" \
       --admin-lastname="${ADMIN_LASTNAME}" \
       --admin-email="${ADMIN_EMAIL}" \
       --admin-user="${ADMIN_USER}" \
       --admin-password="${ADMIN_PASSWORD}" \
       --language="${LANGUAGE}" \
       --currency="${CURRENCY}" \
       --timezone="${TIMEZONE}" \
       --use-rewrites="${URL_REWRITES}" \
       --elasticsearch-host="${SEARCH_ENGINE_HOST}" \
       --elasticsearch-port="${SEARCH_ENGINE_PORT}" \
       --cleanup-database
}

function executeMagento2Commands() {
  echo "**********STARTING executeMagento2Commands**********";
  php bin/magento setup:upgrade
  php bin/magento setup:di:compile
  php bin/magento setup:static-content:deploy -f
  php bin/magento module:disable Magento_TwoFactorAuth
  php bin/magento cache:flush
  chmod 777 -R generated/ pub/ var/
  if [[ ! -f $INSTALL_FILE ]]; then
         echo "**********STARTING Copying Files If Not Exist**********";
         cp /install-config-mysql.php dev/tests/integration/etc/
         cp dev/tests/integration/phpunit.xml.dist dev/tests/integration/phpunit.xml
         cp dev/tests/unit/phpunit.xml.dist dev/tests/unit/phpunit.xml
         chmod 777 -R generated/ pub/ var/
         mysqladmin -hdatabase.magento.docker -uroot -padmin123 create magento2_shop_integration;
     fi
}

function setMagentoDeployMode() {
  echo "**********STARTING setMagentoDeployMode**********";
  if [[ -z $DEPLOY_MODE ]]; then
    php bin/magento deploy:mode:set "${DEPLOY_MODE}"
  fi
}

if [[ ! -f "$FILE" ]]; then
   InstallComposerAndModuleMagento2
   installMagentoProject
   setMagentoDeployMode
   executeMagento2Commands
elif [[ ! -f "$ENV_FILE" ]]; then
   InstallComposerAndModuleMagento2
fi

echo "**********STARTING DOCKER CONTAINER**********";
exec docker-php-entrypoint php-fpm