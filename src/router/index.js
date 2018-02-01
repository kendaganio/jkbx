import Vue from 'vue';
import VueFire from 'vuefire';
import Router from 'vue-router';
import * as firebase from 'firebase';

import SplashPage from '@/components/SplashPage';
import Party from '@/components/Party';
import Player from '@/components/Player';

Vue.use(Router);
Vue.use(VueFire);

const firebaseDb = firebase.initializeApp({
  databaseURL: 'https://jkbx.firebaseio.com',
}).database();

export default new Router({
  routes: [
    {
      path: '/',
      name: 'SplashPage',
      component: SplashPage,
    },
    {
      path: '/party/:id',
      name: 'Party',
      component: Party,
      props: {
        firebaseDb,
      },
    },
    {
      path: '/party/:id/player',
      name: 'Player',
      component: Player,
      props: {
        firebaseDb,
      },
    },
  ],
});
