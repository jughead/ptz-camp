/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb
import 'bootstrap/dist/js/bootstrap'
require.context('../stylesheets/', true, /^\.\/[^_].*\.(css|scss|sass)$/i)
require.context('../images/', true, /\.(gif|jpg|png|svg)$/i)

import {} from 'jquery-ujs'
import Turbolinks from 'turbolinks'
Turbolinks.start()
import ParticipantForm from '../components/participant'
ParticipantForm.register()
import * as Events from '../components/events'

// import App from '../components/app.vue'

// document.addEventListener('DOMContentLoaded', () => {
//   document.body.appendChild(document.createElement('app'))
//   const app = new Vue(App).$mount('app')

//   console.log(app)
// })

