<template>
  <router-view/>
</template>

<script>
export default {
  name: 'App',
};
</script>

<style>
body, input {
  font-family: 'Helvetica Neue', Helvetica, sans-serif;
}

h1 {
  font-family: 'Montserrat', sans-serif;
  font-weight: 800;
}

.fancy-underline {
  background: linear-gradient(180deg,transparent 62%,#81ecec 0) 50%/0 70% no-repeat;
  cursor: pointer;
  background-size: 100% 100%;

}
</style>
