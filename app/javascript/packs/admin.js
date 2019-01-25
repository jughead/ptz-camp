// To load boostrap.css.map
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap/dist/js/bootstrap'
require.context('../stylesheets/', true, /^\.\/[^_].*\.(css|scss|sass)$/i)
require.context('../images/', true, /\.(gif|jpg|png|svg)$/i)

import {} from 'jquery-ujs'
import Turbolinks from 'turbolinks'
Turbolinks.start()

import CkEditor from '../components/admin/html_editor'
CkEditor.start()

