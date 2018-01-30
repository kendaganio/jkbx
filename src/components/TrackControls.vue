<template>
  <div>
    <div class="card">
      <div v-if="!!trackData" class="card-content">
        <div class="level">
          <div class="level-left">
            <img class="level-item" :src="trackData.img"/>
            <div class="level-item">
              <strong class="track-title">{{trackData.title }}</strong>
            </div>
          </div>
        </div>
      </div>

      <div v-else class="card-content">
        No playing track.
      </div>

      <footer class="card-footer">
        <div class="card-footer-item">
          <a class="button is-link is-outlined"><i class="ion-ios-pause"></i></a>
        </div>
        <div class="card-footer-item">
          <a class="button is-link is-outlined"><i class="ion-ios-play"></i></a>
        </div>
        <div class="card-footer-item">
          <a class="button is-link is-outlined"><i class="ion-ios-skipforward"></i></a>
        </div>
      </footer>
    </div>

  </div>
</template>

<script>
export default {
  name: 'TrackControls',
  props: ['trackData'],
};
</script>

<style scoped>
h2 {
  font-family: 'Montserrat', sans-serif;
  font-weight: 800;
  font-size: 1.5rem;
}

.card-content {
  padding: 15px;
}

.track-title {
  font-family: 'Montserrat', sans-serif;
  font-weight: 800;
  font-size: 1.2rem;
  word-wrap: break-word;
  max-width: 500px;
}

a.button {
  width: 100%;
}
</style>
