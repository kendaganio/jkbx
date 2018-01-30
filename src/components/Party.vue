<template>
  <section class="section">
    <h1>🎉 {{ $route.params.id }}</h1>

    <div class="columns">
      <div class="column is-one-half">
        <h2>Hi {{ user }}!  Search for a track to get the party started.</h2>
        <input type="text" class="input" placeholder="Find your favorite artist or song..."/>
        <br/>
        <br/>

        <div v-if="tracks.length === 0">
          <h1>Nada. Add a track, mate!</h1>
        </div>

        <div v-else>
          <h2>Up Next</h2>
          <div :key="track.key" v-for="track in tracks">
            <track-media v-if="!track.playing" :trackData="track" hasRequeue="false"/>
          </div>
        </div>
      </div>

      <div class="column is-one-half">
        <h2>Now Playing</h2>
        <track-controls :trackData="currentTrack"/>
        <br/>
        <a href="http://google.com" target="_blank" class="button is-primary is-outlined small-text full-width">
          Pop-out youtube player
          <i class="icon ion-forward"></i>
        </a>

        <div v-if="playedTracks.length !== 0">
          <h2>Played Tracks</h2>
          <div :key="track.key" v-for="track in playedTracks">
            <track-media :trackData="track" hasRequeue="true"/>
          </div>
        </div>
      </div>

    </div>
  </section>
</template>

<script>
import swal from 'sweetalert';
import TrackMedia from './TrackMedia';
import TrackControls from './TrackControls';

export default {
  name: 'Party',
  props: ['firebaseDb'],

  data() {
    return {
      user: localStorage.jkbxUser,
    };
  },

  firebase() {
    return {
      tracks: this.firebaseDb.ref(`/party/${this.$route.params.id}/tracks`),
      playedTracks: this.firebaseDb.ref(`/party/${this.$route.params.id}/playedTracks`),
    };
  },

  computed: {
    currentTrack() {
      return (this.tracks.length > 0) ? this.tracks[0] : undefined;
    },
  },

  created() {
    if (typeof localStorage.jkbxUser === 'undefined' || localStorage.jkbxUser === 'null') {
      const nameAsker = swal({
        icon: 'info',
        title: 'Hey stranger!',
        text: 'Introduce yourself. :)',
        closeOnEsc: false,
        closeOnClickOutside: false,
        content: {
          element: 'input',
          attributes: {
            placeholder: 'Bob is fine.',
          },
        },
      });

      nameAsker.then((name) => {
        localStorage.jkbxUser = name;
        this.user = name;
      });
    }
  },

  components: {
    TrackMedia,
    TrackControls,
  },
};
</script>

<style scoped>
h1 {
  font-size: 3rem;
}

h2 {
  display: inline-block;
  height: 38px;
  color: #555;
  font-size: 12px;
  line-height: 38px;
  letter-spacing: .1rem;
  text-transform: uppercase;
  text-decoration: none;
  white-space: nowrap;
  box-sizing: border-box;
  margin: 0;
  padding-left: 5px;
  font-weight: 700;
}

.small-text {
  display: inline-block;
  height: 38px;
  color: #555;
  font-size: 12px;
  line-height: 30px;
  letter-spacing: .1rem;
  text-transform: uppercase;
  text-decoration: none;
  white-space: nowrap;
  font-weight: 700;
}

.full-width {
  width: 100%;
}
</style>
