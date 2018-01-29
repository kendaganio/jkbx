<template>
  <article class="box media" :key="trackData.key">
    <figure class="media-left">
      <img :src="trackData.img"/>
    </figure>
    <div class="media-content">
      <div class="content">
        <strong>
          <a :href="youtubeLink" target="_blank">
            {{ trackData.title }}
          </a>
        </strong>

        <nav class="level">
          <div class="level-left">
            <span class="tag level-item">
            <i class="icon ion-android-person-add"></i> {{ trackData.addedBy }}
            </span>
            <a @click="removeTrack(trackData.key)" class="level-item">
              <i class="icon ion-close-round"></i>
            </a>
            <a v-if="hasRequeue === 'true'" class="level-item">
              <i class="icon ion-refresh"></i> Re-queue
            </a>
          </div>
        </nav>
      </div>
    </div>
  </article>
</template>

<script>
export default {
  name: 'TrackMedia',
  props: ['trackData', 'hasRequeue'],

  computed: {
    youtubeLink() {
      return "https://youtube.com/watch?v=" + this.trackData.videoId;
    }
  },

  methods: {
    removeTrack(event, key) {
      alert(`removing -- ${key}`);
    },
  },
};
</script>

<style scoped>
article.media {
  border-radius: 0;
}

.media-left img {
  width: 60px;
}
</style>
