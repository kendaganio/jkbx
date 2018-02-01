<template>
  <article class="box media" :key="trackData.key">
    <figure class="media-left">
      <img :src="trackData.img"/>
    </figure>
    <div class="media-content">
      <div class="content">
        {{ trackData.title }}
        <a :href="youtubeLink" title="Open video in new tab" target="_blank">
          <i class="icon ion-android-open"></i>
        </a>

        <nav class="level is-mobile">
          <div class="level-left">
            <span class="tag level-item">
              {{ trackData.addedBy }}
            </span>
            <span class="level-item">
              <a v-if="hasRequeue === 'true'" @click="requeue">
                <i class="icon ion-refresh"></i> Requeue
              </a>
            </span>
          </div>
        </nav>
      </div>
    </div>

    <div class="media-right">
      <a @click="removeTrack" class="delete"></a>
    </div>
  </article>
</template>

<script>
export default {
  name: 'TrackMedia',
  props: ['trackData', 'hasRequeue'],

  computed: {
    youtubeLink() {
      return `https://youtube.com/watch?v=${this.trackData.videoId}`;
    },
  },

  methods: {
    removeTrack() {
      this.$emit('remove-track', this.trackData);
    },

    requeue() {
      const data = Object.assign({}, this.trackData);
      delete data['.key'];

      this.$emit('requeue-track', data);
    },
  },
};
</script>

<style scoped>
article.media {
  padding: 0.5rem;
  border-radius: 0;
}

.media-left img {
  width: 60px;
}
</style>
