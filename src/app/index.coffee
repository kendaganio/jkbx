angular.module 'jkbx', ['ngAnimate', 'ngCookies', 'ngTouch', 'ngSanitize', 'ui.router', 'firebase']
  .config ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state "home",
        url: "/",
        templateUrl: "app/main/main.html",
        controller: "MainCtrl"

      .state "party",
        url: "/party/:name",
        templateUrl: "app/party/party.html",
        controller: "PartyCtrl"

      .state "player",
        url: "/party/:name/player",
        templateUrl: "app/player/player.html",
        controller: "PlayerCtrl"


    $urlRouterProvider.otherwise '/'

