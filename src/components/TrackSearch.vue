<template>
  <div :class="dropdownClass">
    <input
      @keyup="searchTrack"
      v-model="searchText"
      type="text"
      class="input is-fullwidth"
      placeholder="Find your favorite artist or song..."
    />

    <div class="dropdown-menu">
      <div class="dropdown-content">
        <div @click="addTrack(result)" class="dropdown-item"
             :key="result.id.videoId" v-for="result in searchResults">
          <img :src="result.snippet.thumbnails.default.url"/>
          {{ result.snippet.title }} <strong> - {{ result.snippet.channelTitle}}</strong>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
export default {
  name: 'TrackSearch',

  data() {
    return {
      searchText: '',
      searchResults: [],
    };
  },

  computed: {
    dropdownClass() {
      return {
        dropdown: true,
        'is-active': (this.searchResults.length > 0),
      };
    },
  },

  methods: {
    searchTrack() {
      if (this.searchText.length > 3) {
        const request = window.gapi.client.youtube.search.list({
          q: this.searchText,
          part: 'snippet',
          type: 'video',
        });

        request.execute((res) => {
          this.searchResults = res.items;
        });
      } else {
        this.searchResults = [];
      }
    },

    addTrack(track) {
      const newTrack = {
        videoId: track.id.videoId,
        title: track.snippet.title,
        img: track.snippet.thumbnails.default.url,
      };
      this.$emit('add-track', newTrack);
      this.searchResults = [];
      this.searchText = '';
    },
  },
};
</script>

<style scoped>
.dropdown {
  width: 100%;
}

input {
  width: 100%;
}

.dropdown-menu {
  width: 100%;
}

.dropdown-content {
  padding: 0;
}

.dropdown-item img {
  width: 40px;
  padding-right: 10px;
}

.dropdown-item {
  display: flex;
  align-items: center;
  border-bottom: 1px solid #dbdbdb;
  cursor: pointer;
}

.dropdown-item:hover, .dropdown-item:hover strong {
  background: #00d1b2;
  color: white;
}
</style>
