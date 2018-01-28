<template>
  <section class="hero is-primary is-medium">
    <div class="hero-body">
      <div class="container has-text-centered">
        <h1 class="title">Queue it up!</h1>
        <h2 class="subtitle">
          jkbx is a simple collaborative
          <br/>YouTube playlist for all.
        </h2>

        <form v-on:submit="getTurnt">
          <input type="text" class="input is-large" id="playlist" v-model="playlist" />
        </form>
      </div>
    </div>
  </section>
</template>

<script>
import Typed from 'typed.js';

export default {
  name: 'SplashPage',
  data() {
    return {
      msg: 'Welcome to Your Vue.js App',
      typer: undefined,
      playlist: '',
    };
  },

  mounted() {
    this.typer = new Typed('#playlist', {
      strings: ['super-emo-songs', 'bed-weather', 'happy-birthday-jeff', 'the-cake-is-a-lie'],
      typeSpeed: 50,
      loop: true,
      attr: 'placeholder',
      bindInputFocusEvents: true,
    });
  },

  methods: {
    clearText() {
      this.typer.stop();
      this.playlist = '';
    },

    getTurnt(event) {
      event.preventDefault();
      this.$router.push({ name: 'Party', params: { id: this.playlist } });
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1 {
  font-size: 3rem;
  padding: 20px;
}

h2.subtitle {
  font-size: 2rem;
}

input#playlist {
  background: transparent;
  border: none;
  border-bottom: 5px solid white;
  color: white;
  box-shadow: none;
  padding: 10px 10px;

  width: 30%;
  text-align: center;
}
</style>
