<?php
return [
    'db' => [
        'username' => getenv('SHOPWARE_DB_USER'),
        'password' => getenv('SHOPWARE_DB_PASSWORD'),
        'dbname' => getenv('SHOPWARE_DB_NAME'),
        'host' => getenv('SHOPWARE_DB_HOST'),
        'port' => getenv('SHOPWARE_DB_PORT')
    ],
    'phpsettings' => [
        'display_errors' => 1
    ],

    'front' => [
        'throwExceptions' => true,
        'showException' => true
    ]
];
