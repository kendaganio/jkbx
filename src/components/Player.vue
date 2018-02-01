<template>
  <section>
    <youtube
      @ready="ready"
      @ended="ended"
      :video-id="videoId"
      :width="playerWidth"
      :height="playerHeight"
      :player-vars="playerVars"
    ></youtube>
  </section>
</template>

<script>
export default {
  name: 'Player',
  props: ['firebaseDb'],

  data() {
    return {
      videoId: '',
      controls: {},
      playerVars: {
        autoplay: 1,
      },
      player: undefined,
    };
  },

  computed: {
    playerHeight() {
      return window.innerHeight;
    },
    playerWidth() {
      return window.innerWidth;
    },
  },

  firebase() {
    return {
      tracks: {
        source: this.firebaseDb.ref(`/party/${this.$route.params.id}/tracks`),
        readyCallback() {
          this.queueTrack(this.firstTrack());
        },
      },
      playedTracks: this.firebaseDb.ref(`/party/${this.$route.params.id}/playedTracks`),
      controls: {
        source: this.firebaseDb.ref(`/party/${this.$route.params.id}/controls`),
        asObject: true,
      },
    };
  },

  watch: {
    controls(controls) {
      switch (controls.action) {
        case 'pause':
          this.player.pauseVideo();
          break;
        case 'play':
          this.player.playVideo();
          break;
        case 'skip':
          this.player.seekTo(this.player.getDuration());
          break;
        default:
          break;
      }
    },
  },

  methods: {
    ready(player) {
      this.player = player;
    },

    ended() {
      const track = this.firstTrack();
      this.$firebaseRefs.playedTracks.push(this.stripKey(track));
      this.$firebaseRefs.tracks.child(track['.key']).remove();

      this.queueTrack(this.firstTrack());
    },

    firstTrack() {
      return this.tracks[0];
    },

    stripKey(track) {
      const t = { ...track };
      delete t['.key'];
      return t;
    },

    updateTrack(key, payload) {
      this.$firebaseRefs.tracks.child(key).set(payload);
    },

    queueTrack(track) {
      this.videoId = track.videoId;
      const trackCopy = { ...this.stripKey(track), playing: true };
      this.updateTrack(track['.key'], trackCopy);
      this.player.playVideo();
    },
  },
};
</script>

<style scoped>
h1 {
  font-size: 2rem;
}
</style>
