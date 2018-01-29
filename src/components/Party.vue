<template>
  <section class="section">
    <h1>{{ $route.params.id }}'s playlist</h1>

    <div class="columns">
      <div class="column is-one-half">
        <div v-if="tracks.length === 0">
          <h2>Search for a song to get the party started</h2>
        </div>
        <div v-else>
          <div :key="track.key" v-for="track in tracks">
            <track-media :trackData="track" hasRequeue="false"/>
          </div>
        </div>
      </div>
      <div class="column is-one-half">
        <div :key="track.key" v-for="track in playedTracks">
          <track-media :trackData="track" hasRequeue="true"/>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import TrackMedia from './TrackMedia';

export default {
  name: 'Party',
  props: ['firebaseDb'],

  data() {
    return {
      test: 'ok',
    };
  },

  firebase() {
    return {
      tracks: this.firebaseDb.ref(`/party/${this.$route.params.id}/tracks`),
      playedTracks: this.firebaseDb.ref(`/party/${this.$route.params.id}/playedTracks`),
    };
  },

  components: {
    TrackMedia,
  },
};
</script>

<style scoped>
h1 {
  font-size: 2rem;
}
</style>
