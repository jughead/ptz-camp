import Vue from 'vue/dist/vue.esm'
import Teams from '../components/teams'
import {} from 'jquery-ujs'
// import TurbolinksAdapter from 'vue-turbolinks';

// Vue.use(TurbolinksAdapter)

document.addEventListener('DOMContentLoaded', () => {
  var element = document.getElementById('teams')
  if (element != null) {
    new Vue({
      el: element,
      components: {
        teams: Teams,
      }
    });
  }
});
