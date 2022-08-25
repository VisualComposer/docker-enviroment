<?php
/**
 * Will display js errors and app global variable will be available in the browser console.
 */
VcvEnv::set('VCV_DEBUG', true);
/**
 * Set false to view send ajax requests data without compression
 */
VcvEnv::set('VCV_JS_SAVE_ZIP', false);
/**
 * Set true to use elements and addons from devElements and devAddons directory.
 * Note: Plugin settings reset is required after changing the value of this variable
 * @var boolean
 */
$devHub = true;
VcvEnv::set('VCV_ENV_DEV_ADDONS', $devHub);
VcvEnv::set('VCV_ENV_DEV_ELEMENTS', $devHub);

/**
 * Comment these VCV_* env variables if you want to test with production settings
 */
VcvEnv::set('VCV_HUB_URL', 'https://staging.my.visualcomposer.com');
VcvEnv::set('VCV_TOKEN_URL', 'https://staging.my.visualcomposer.com/authorization-token');
VcvEnv::set('VCV_PREMIUM_TOKEN_URL', 'https://staging.my.visualcomposer.com/authorization-token');
VcvEnv::set('VCV_ACTIVATE_LICENSE_URL', 'https://staging.my.visualcomposer.com/?edd_action=activate_license&item_name=Visual%20Composer');

require_once "env.php";
require_once "devElements/.php-modules/bootstrap.php";
