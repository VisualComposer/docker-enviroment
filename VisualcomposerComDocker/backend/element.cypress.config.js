const { defineConfig } = require('cypress')

module.exports = defineConfig({
  env: {
    baseUrl: 'http://wp.visualcomposer.com.localhost:8038',
    wpUserName: 'jelagum',
    wpPassword: 'rM)i[K~PetI6',
    dataPlugin: 'visualcomposer/plugin-wordpress.php',
    newPage: '/wp-admin/post-new.php?post_type=page&vcv-action=frontend',
    vcvAdminAjaxUrl: '/wp-admin/admin-ajax.php?vcv-admin-ajax=1&action=vcv-admin-ajax',
    serverType: 'ci',
  },
  video: true,
  pageLoadTimeout: 80000,
  execTimeout: 350000,
  wpUserName: 'jelagum',
  wpPassword: 'rM)i[K~PetI6',
  dataPlugin: 'visualcomposer/plugin-wordpress.php',
  newPage: '/wp-admin/post-new.php?post_type=page&vcv-action=frontend',
  vcvAdminAjaxUrl: '/wp-admin/admin-ajax.php?vcv-admin-ajax=1&action=vcv-admin-ajax',
  serverType: 'ci',
  e2e: {
    // We've imported your old cypress plugins here.
    // You may want to clean this up later by importing these.
    setupNodeEvents(on, config) {
      return require('./cypress/plugins/index.js')(on, config)
    },
    baseUrl: 'http://wp.visualcomposer.com.localhost:8038',
  },
})
