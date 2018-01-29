<template>
  <ul>
    <li v-for="team in teams">
      {{ team.full_name }}
    </li>
  </ul>
</template>

<script>
  import CurrentCamp from './utils/current_camp'

  const teamsUrl = function (app) {
    let url = '/api/v1/camps/' + CurrentCamp.id + '/teams';
    if (app.my) {
      url += '/my';
    }
    return url;
  }

  const loadTeams = function () {
    const app = this;
    $.ajax({
      url: teamsUrl(app),
      method: 'GET',
      success: function(data) {
        app.teams = data
      },
      error: function(error) {
        console.log(error);
      }
    });
  };

  export default {
    props: {
      my: {
        type: Boolean,
      }
    },
    data () {
      return {
        teams: [],
      }
    },
    created: function () {
      console.log(this.my);
    },
    mounted: loadTeams
  }
</script>

<style scoped>
  li {
    list-style-type: decimal;
  }
</style>
