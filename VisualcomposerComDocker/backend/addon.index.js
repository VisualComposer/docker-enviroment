const fs = require('fs')

const filePath = '../../../../tests/cypressConfig/cypress/plugins/index.js'
if (fs.existsSync(filePath)) {
    module.exports = require(filePath)
} else {
    module.exports = require('../../../../tests/cypressConfig/cypress/plugins/index.js')
}
