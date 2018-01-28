<template>
  <section class="section">
    <h1>{{ $route.params.id }}'s playlist</h1>
  </section>
</template>

<script>
export default {
  name: 'Party',

  data() {
    return {
      test: 'ok',
    };
  },
};
</script>

<style scoped>
h1 {
  font-size: 2rem;
}
</style>
