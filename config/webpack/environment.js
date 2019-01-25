const { environment } = require('@rails/webpacker')
const vue = require('./loaders/vue')
const coffee = require('./loaders/coffee')
environment.loaders.append('vue', vue)
environment.loaders.append('coffee', coffee)

const webpack = require('webpack')

environment.plugins.append('Provide', new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    'window.jQuery': 'jquery',
  })
)

environment.loaders.get('sass').use.splice(-1, 0, {
  loader: 'resolve-url-loader'
})

// const config = environment.toWebpackConfig()

// config.resolve.alias = {
//   jquery: "jquery/src/jquery",
//   // vue: "vue/dist/vue.js",
//   // vue_resource: "vue-resource/dist/vue-resource",
// }

module.exports = environment
