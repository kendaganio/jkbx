import Vue from 'vue';
import Router from 'vue-router';
import SplashPage from '@/components/SplashPage';
import Party from '@/components/Party';
import Player from '@/components/Player';

Vue.use(Router);

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
    },
    {
      path: '/party/:id/player',
      name: 'Player',
      component: Player,
    },
  ],
});
