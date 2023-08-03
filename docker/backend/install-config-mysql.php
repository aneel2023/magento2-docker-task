<?php
/**
 * Copyright    Magento, Inc. All rights reserved.
 * See COPYING.txt for license details.
 */

return [
    'db-host' => 'database.magento.docker',
    'db-user' => 'root',
    'db-password' => 'admin123',
    'db-name' => 'magento2_shop_integration',
    'db-prefix' => '',
    'backend-frontname' => 'admin',
    'search-engine' => 'elasticsearch7',
    'elasticsearch-host' => 'elasticsearch.magento.docker',
    'elasticsearch-port' => 9200,
    'admin-user' => \Magento\TestFramework\Bootstrap::ADMIN_NAME,
    'admin-password' => \Magento\TestFramework\Bootstrap::ADMIN_PASSWORD,
    'admin-email' => \Magento\TestFramework\Bootstrap::ADMIN_EMAIL,
    'admin-firstname' => \Magento\TestFramework\Bootstrap::ADMIN_FIRSTNAME,
    'admin-lastname' => \Magento\TestFramework\Bootstrap::ADMIN_LASTNAME,
    /*'amqp-host' => 'localhost',
    'amqp-port' => '5672',
    'amqp-user' => 'guest',
    'amqp-password' => 'guest',
    'consumers-wait-for-messages' => '0',*/
];
