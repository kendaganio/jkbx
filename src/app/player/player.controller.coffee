angular.module "jkbx"
  .controller "PlayerCtrl", ($scope, $stateParams, $firebaseArray, $firebaseObject) ->

    # Firebase stuff
    tracksRef = new Firebase("https://jkbx.firebaseio.com/party/#{$stateParams.name}/tracks")
    controlsRef = new Firebase("https://jkbx.firebaseio.com/party/#{$stateParams.name}/controls")

    $scope.tracks = $firebaseArray(tracksRef)
    $scope.controls = $firebaseObject(controlsRef)
    $scope.playerHeight = window.innerHeight
    $scope.playerWidth = window.innerWidth
    $scope.index = 0
    $scope.player = null

    $scope.controls.$watch (_stuff) ->
      switch $scope.controls.action
        when 'pause' then $scope.player.pauseVideo()
        when 'play' then $scope.player.playVideo()
        when 'skip' then $scope.player.seekTo($scope.player.getDuration())

    $scope.tracks.$loaded().then (_tracks) ->
      console.log 'Tracks loaded'
      $scope.playing = $scope.tracks[0]

    $scope.$on 'youtube.player.ready', ($event, player) ->
      $scope.playing.playing = true
      $scope.tracks.$save($scope.playing)
      $scope.player = player
      $scope.player.playVideo()

    $scope.$on 'youtube.player.ended', ($event, player) ->
      $scope.playing.playing = false
      $scope.tracks.$save($scope.playing)
      $scope.index += 1
      $scope.playing = $scope.tracks[$scope.index]

