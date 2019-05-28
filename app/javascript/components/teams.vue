<template>
  <div>
    <div v-if="my">
      <div class="row">
        <div class="form-group col-xs-5">
          <label for="newTeamName">Enter new team name</label>
          <input autocomplete="off" v-model="newTeam.name" class="form-control" id="newTeamName"/>
        </div>
      </div>
      <div class="row">
        <div class="form-group col-xs-5" v-if="canEnterNewUser">
          <label class="form-control">
            <input v-model="newTeam.withLaptop" type="checkbox"/> We'll bring a laptop instead of using host's computer.
          </label>
          <div v-if="newTeam.withLaptop === true">
            <label class="form-control">
              <input v-model="newTeam.withDisplay" type="checkbox"/> We need a display.
            </label>
            <label class="form-control">
              <input v-model="newTeam.keyboard" type="checkbox"/> We need a keyboard.
            </label>
            <label class="form-control">
              <input v-model="newTeam.mouse" type="checkbox"/> We need a mouse.
            </label>
          </div>
          <autocomplete ref="autocomplete" input-attrs="autocomplete=off" placeholder="Enter team member name" input-class="form-control" :source="participantsEndpoint" resultsProperty="data" :results-display="participantDisplay" @selected="addParticipant"/>
        </div>
      </div>
      <div class="row">
        <ul>
          <li v-for="member in newTeam.members" class="newteam-member">
            {{ member.name }} <a @click="removeParticipant(member)">&times;</a>
          </li>
        </ul>
      </div>
      <div class="row has-error text text-danger" v-if="newTeam.errors">
        <p>
          <ul>
            <li v-for="error in newTeam.errors">
              {{ error }}
            </li>
          </ul>
        </p>
      </div>
      <div class="row">
        <div class="form-actions">
          <button v-if="canSubmit" class="btn btn-primary" type="submit" @click="create">Create team</button>
        </div>
      </div>
    </div>
    <ul>
      <li v-for="team in teams" class="teams">
        {{ team.full_name }}
        <span class="badge" v-if="showTeamLaptopBadge(team, 'with_laptop')">laptop</span>
        <span class="badge" v-if="showTeamLaptopBadge(team, 'with_display')">display</span>
        <span class="badge" v-if="showTeamLaptopBadge(team, 'keyboard')">keyboard</span>
        <span class="badge" v-if="showTeamLaptopBadge(team, 'mouse')">mouse</span>
        <a href="#" @click="destroyTeam(team)" v-if="my">&times;</a>
      </li>
    </ul>
  </div>
</template>

<script>
  import Autocomplete from 'vuejs-auto-complete'
  import CurrentCamp from './utils/current_camp'

  const teamsUrl = function (app, my) {
    let url = '/api/v1/camps/' + CurrentCamp.id + '/teams';
    if (my) {
      url += '/my';
    }
    return url;
  }

  export default {
    props: {
      my: Boolean,
      initialTeams: Array
    },
    data () {
      return {
        teams: this.initialTeams,
        newTeam: {
          name: '',
          withLaptop: false,
          withDisplay: false,
          mouse: false,
          keyboard: false,
          members: [],
          errors: [],
        }
      }
    },
    mounted () {
      this.loadTeams()
    },
    computed: {
      canSubmit: function () {
        return this.newTeam.name.length > 0 && this.newTeam.members.length > 0;
      },
      canEnterNewUser: function () {
        return this.newTeam.name.length > 0 && this.newTeam.members.length < 3;
      },
    },
    methods: {
      participantsEndpoint (query) {
        return '/api/v1/camps/' + CurrentCamp.id + '/participants/unused?q=' + query
      },
      participantDisplay (result) {
        return result.name;
      },
      addParticipant (item) {
        if (this.newTeam.members.map((i => i.id)).indexOf(item.value) === -1) {
          this.newTeam.members.push({id: item.value, name: item.display})
        }
        this.$refs.autocomplete.clear()
      },
      removeParticipant (item) {
        this.newTeam.members.splice(this.newTeam.members.indexOf(item), 1);
      },
      loadTeams () {
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
      },
      clearForm () {
        this.newTeam.members.length = 0
        this.newTeam.name = ''
        this.newTeam.errors = {}
        this.newTeam.withLaptop = false
        this.newTeam.withDisplay = false
        this.newTeam.keyboard = false
        this.newTeam.mouse = false
      },
      destroyTeam (team) {
        const app = this;
        const url = teamsUrl(this, false)
        $.ajax({
          url: url + '/' + team.id,
          method: 'DELETE',
          success: function() {
            app.loadTeams();
          },
          error: function(error) {
            console.log(error);
          }
        })
      },
      showTeamLaptopBadge (team, key) {
        const authorization = this.my == true;
        return authorization && team[key];
      },
      create () {
        const app = this;
        const url = teamsUrl(this, false);
        $.ajax({
          url: url,
          method: 'POST',
          data: {
            name: this.newTeam.name,
            with_laptop: this.newTeam.withLaptop,
            with_display: this.newTeam.withDisplay,
            keyboard: this.newTeam.keyboard,
            mouse: this.newTeam.mouse,
            participant_ids: this.newTeam.members.map((i => i.id))
          },
          success: function(data) {
            app.clearForm();
            app.loadTeams();
          },
          error: function(jqXHR, textStatus, error) {
            if (jqXHR.status == 422) {
              app.newTeam.errors.length = 0
              Object.entries(JSON.parse(jqXHR.responseText).errors).forEach(function(entry) {
                app.newTeam.errors.push(entry.key + ': ' + entry.value.join(', '))
              })
              return false;
            } else if (jqXHR.status == 403) {
              app.newTeam.errors = [JSON.parse(jqXHR.responseText).error]
              return false;
            }
          }
        })
      }
    },
    components: {
      Autocomplete
    }
  }
</script>

<style scoped>
  li.teams {
    list-style-type: decimal;
  }
  li.newteam-member {
  }
  .has-error li {
    list-style: none;
  }
</style>
