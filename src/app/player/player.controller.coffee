angular.module "jkbx"
  .controller "PlayerCtrl", ($scope, $stateParams, $firebaseArray, $firebaseObject) ->

    # Firebase stuff
    ref =
      tracks: new Firebase("https://jkbx.firebaseio.com/party/#{$stateParams.name}/tracks")
      controls: new Firebase("https://jkbx.firebaseio.com/party/#{$stateParams.name}/controls")
      playedTracks: new Firebase("https://jkbx.firebaseio.com/party/#{$stateParams.name}/playedTracks")

    $scope.tracks = $firebaseArray(ref.tracks)
    $scope.playedTracks = $firebaseArray(ref.playedTracks)
    $scope.controls = $firebaseObject(ref.controls)
    $scope.playerHeight = window.innerHeight
    $scope.playerWidth = window.innerWidth
    $scope.player = null

    nextTrack = ->
      $scope.tracks.$remove(0).then ->
        if $scope.tracks[0]
          $scope.playing = $scope.tracks[0]
        else
          $scope.playing = null
          $scope.player.stopVideo()

    $scope.controls.$watch (_stuff) ->
      console.log $scope.controls.action
      switch $scope.controls.action
        when 'pause'
          $scope.player.pauseVideo()
        when 'play'
          if $scope.player.getPlayerState() == YT.PlayerState.PAUSED
            $scope.player.playVideo()
          else
            $scope.playing = $scope.tracks[0]
        when 'skip'
          $scope.player.seekTo($scope.player.getDuration())

    $scope.tracks.$loaded().then (_tracks) ->
      console.log 'Tracks loaded'
      $scope.playing = $scope.tracks[0]

    $scope.$on 'youtube.player.ready', ($event, player) ->
      window.wew = $scope
      $scope.playing.playing = true
      $scope.tracks.$save($scope.playing)
      $scope.player = player
      $scope.player.playVideo()

    $scope.$on 'youtube.player.ended', ($event, player) ->
      $scope.playedTracks.$add($scope.playing)
      nextTrack()

