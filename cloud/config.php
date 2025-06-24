<?php
$CONFIG = array (
  'htaccess.RewriteBase' => '/',
  'memcache.local' => '\\OC\\Memcache\\APCu',
  'apps_paths' => 
  array (
    0 => 
    array (
      'path' => '/var/www/html/apps',
      'url' => '/apps',
      'writable' => false,
    ),
    1 => 
    array (
      'path' => '/var/www/html/custom_apps',
      'url' => '/custom_apps',
      'writable' => true,
    ),
  ),
  'memcache.distributed' => '\\OC\\Memcache\\Redis',
  'memcache.locking' => '\\OC\\Memcache\\Redis',
  'redis' => 
  array (
    'host' => 'redis',
    'password' => '',
    'port' => 6379,
  ),
  'upgrade.disable-web' => true,
  'passwordsalt' => 'cNXPN19Mh9oQFbJEYLMhP2Tz0d3b5K',
  'secret' => 'j4HgNEkhvJfWlT1Rs3nsNWL+N/ye5GyS9QH+hjNNdAqJDaes',
  'trusted_domains' => 
  array (
    0 => 'localhost',
    2 => 'cloud.landingpad.digital',
  ),
  'datadirectory' => '/var/www/html/data',
  'dbtype' => 'mysql',
  'version' => '31.0.6.2',
  'overwrite.cli.url' => 'https://cloud.landingpad.digital',
  'dbname' => 'nextcloud',
  'dbhost' => 'db',
  'dbport' => '',
  'dbtableprefix' => 'oc_',
  'mysql.utf8mb4' => true,
  'dbuser' => 'nextcloud',
  'dbpassword' => 'P1jWygQXzD0',
  'installed' => true,
  'instanceid' => 'oc96sqf3by0w',
  'trusted_proxies' => 
  array (
    0 => '127.0.0.1',
  ),
  'overwriteprotocol' => 'https',
  'mail_smtpmode' => 'smtp',
  'mail_smtphost' => 'send.one.com',
  'mail_sendmailmode' => 'smtp',
  'mail_from_address' => 'support',
  'mail_domain' => 'landingpad.digital',
  'mail_smtpport' => '465',
  'mail_smtpauth' => true,
  'mail_smtpname' => 'support@landingpad.digital',
  'mail_smtppassword' => 'mkt_Support_77',
);
