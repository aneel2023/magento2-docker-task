# Magento2 Docker For Shopfinder

# Included
Nginx, PHP8.1, Mysql, elasticsearch and Magento 2.4.5.

# Docker Installation

Clone `magento2-docker-task` directory with command `git clone https://github.com/aneel2023/magento2-docker-task.git` 
and then run `docker-compose up -d` or `docker compose up -d` according to your docker version.

Wait for 30-40 minutes, it will install Magento2.4.5. Once it is finished then add host entry `127.0.0.1 magento2.local` 
and open URL `http://magento2.local/` in browser.

Access docker image backend ny command `docker exec -it m2backend sh`  

In this setup, Magento2.4.5 will be installed if not already installed and database will also remain persistent if you  
shut down docker.

# Magento Admin Access Detail
Magento URL: http://magento2.local/admin  
Admin Username: admin
Admin Password: admin123

# Magento2 Shopfinder Module
Shopfinder module will automatically be installed with this docker setup.

## Run All PHP Unit Tests
1. Run command `docker exec -it m2backend sh` to access docker php server with magento code access.
2. Run following command from project root directory `/var/www/html` to execute all shopfinder unit test cases:

   `vendor/bin/phpunit -c dev/tests/unit/phpunit.xml vendor/anee/shopfinder/Test/Unit/`

In above command, replace folder path with full file path if want to run test case for single file.

## Run All PHP Integration Tests

1. Run command `docker exec -it m2backend sh` to access docker php server with magento code access.
2. Got to directory `cd dev/tests/integration`
3. Run following command from above directory:

   `../../../vendor/bin/phpunit ../../../vendor/anee/shopfinder/Test/Integration/`

In above command, replace folder path with full file path if want to run test case for single file.


``Contact: developer.anil88@gmail.com for any issue.``
