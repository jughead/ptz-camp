import Vue from 'vue/dist/vue.esm'
import Teams from '../components/teams'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#teams',
    components: {
      teams: Teams,
    }
  });
})
