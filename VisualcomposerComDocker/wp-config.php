<?php
/**
 * Основные параметры WordPress.
 *
 * Скрипт для создания wp-config.php использует этот файл в процессе
 * установки. Необязательно использовать веб-интерфейс, можно
 * скопировать файл в "wp-config.php" и заполнить значения вручную.
 *
 * Этот файл содержит следующие параметры:
 *
 * * Настройки MySQL
 * * Секретные ключи
 * * Префикс таблиц базы данных
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** Параметры MySQL: Эту информацию можно получить у вашего хостинг-провайдера ** //
/** Имя базы данных для WordPress */
define('DB_NAME', 'wordpress');

/** Имя пользователя MySQL */
define('DB_USER', 'wordpress');

/** Пароль к базе данных MySQL */
define('DB_PASSWORD', 'wordpress');

/** Имя сервера MySQL */
define('DB_HOST', 'mariadb');

/** Кодировка базы данных для создания таблиц. */
define('DB_CHARSET', 'utf8');

/** Схема сопоставления. Не меняйте, если не уверены. */
define('DB_COLLATE', '');

define('FS_METHOD', 'direct');

define( 'WP_HOME', 'http://wp.visualcomposer.com.localhost:8038' );
define( 'WP_SITEURL', 'http://wp.visualcomposer.com.localhost:8038' );

/**#@+
 * Уникальные ключи и соли для аутентификации.
 *
 * Смените значение каждой константы на уникальную фразу.
 * Можно сгенерировать их с помощью {@link https://api.wordpress.org/secret-key/1.1/salt/ сервиса ключей на WordPress.org}
 * Можно изменить их, чтобы сделать существующие файлы cookies недействительными. Пользователям потребуется авторизоваться снова.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '|JZ{A{ <f<;4o5nYeRZebOD J(,v$!;Oq<+d8+h*u_zmm.`.KRL0kVq&*~?vin7-');
define('SECURE_AUTH_KEY',  '1v.A77$TYf;tFC!8x6+ak$30%|FrJ]V@G>xCx23=LX4:&-a|&Ia_9_QUaa0ac~=m');
define('LOGGED_IN_KEY',    'nf?4)XR|3G{D>[b$Tv!b,)ByQkx,+M2.=!HF`8pBp!]>nXSOfKzE[FDQ]]kO^L9E');
define('NONCE_KEY',        'M4&FFG:HZiB2$[^7H,%t0v]++KT(F5QAmEJFck=Y=[M#=wF_@[AT=UG?_5Ck?~-b');
define('AUTH_SALT',        'MiHCE@9FCR Pp4,DV4$/+X9a7j<c^a4 O )g8HplkcJ|nhKE%#B@;PS^z|Gd{#%2');
define('SECURE_AUTH_SALT', 'tb;G>MUwlmd::u6zbOg^;Es_>AsBS-UILmr;|3BMu:1C0S!HAL?{}|?*b<O#O4&k');
define('LOGGED_IN_SALT',   '^`&->l)PM97#Gn3=*^rOS[bN?W+yT,0#eGsmb(J>>Ej)mFQn&8C!ZR}7|W;!3jl2');
define('NONCE_SALT',       'O^U&heqB`?ma2gVw +xT{!zXc~@ncsu]&S`W{19+xVjd$@e-1AaT/gZzxA5>^=JL');

/**#@-*/

/**
 * Префикс таблиц в базе данных WordPress.
 *
 * Можно установить несколько сайтов в одну базу данных, если использовать
 * разные префиксы. Пожалуйста, указывайте только цифры, буквы и знак подчеркивания.
 */
$table_prefix  = 'wp_';

/**
 * Для разработчиков: Режим отладки WordPress.
 *
 * Измените это значение на true, чтобы включить отображение уведомлений при разработке.
 * Разработчикам плагинов и тем настоятельно рекомендуется использовать WP_DEBUG
 * в своём рабочем окружении.
 * 
 * Информацию о других отладочных константах можно найти в Кодексе.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
ini_set('display_errors', 1);
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', true);
define('SCRIPT_DEBUG', true);
define('SAVEQUERIES', true);
define('AUTOSAVE_INTERVAL', 1800);
define('WP_POST_REVISIONS', true);
// any file type upload permission
define('ALLOW_UNFILTERED_UPLOADS', true);

// define('ALLOW_UNFILTERED_UPLOADS', true);

/* Это всё, дальше не редактируем. Успехов! */

/** Абсолютный путь к директории WordPress. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Инициализирует переменные WordPress и подключает файлы. */
require_once(ABSPATH . 'wp-settings.php');
