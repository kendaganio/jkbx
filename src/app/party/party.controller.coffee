angular.module "jkbx"
  .controller "PartyCtrl", ($scope, $stateParams, $firebaseArray, $firebaseObject) ->

    ref =
      tracks: new Firebase("https://jkbx.firebaseio.com/party/#{$stateParams.name}/tracks")
      controls: new Firebase("https://jkbx.firebaseio.com/party/#{$stateParams.name}/controls")
      playedTracks: new Firebase("https://jkbx.firebaseio.com/party/#{$stateParams.name}/playedTracks")

    controls = $firebaseObject(ref.controls)

    $scope.user = 'Stranger'
    $scope.party = $stateParams.name
    $scope.newTrack = {}
    $scope.tracks = $firebaseArray(ref.tracks)
    $scope.playedTracks = $firebaseArray(ref.playedTracks)
    $scope.loadingTracks = true

    if localStorage.jkbx_name
      $scope.user = localStorage.jkbx_name
    else
      swal {
        title: 'Hello, stranger! Tell me your name.'
        type: 'input'
        showCancelButton: false
        closeOnConfirm: false
        animation: 'slide-from-top'
        inputPlaceholder: 'Bob is fine.'
      }, (name) ->
        if name == false
          return false
        if name == ''
          swal.showInputError 'You need to introduce yourself!'
          return false

        localStorage.jkbx_name = name
        swal 'Legit!', "Welcome to the party #{name}!", 'success'
        $scope.user = name

    $scope.tracks.$loaded().then ->
      $scope.loadingTracks = false

    $scope.trackAction = (action) ->
      controls.action = action
      controls.time = Date.now()
      controls.$save().then ->
        console.log 'pew pew -- ', controls

    $scope.addTrack = (track) ->
      $scope.tracks.$add
        img: track.snippet.thumbnails.default.url
        title: track.snippet.title
        videoId: track.id.videoId
        playing: false
        addedBy: $scope.user

      $scope.newTrack.name = ''

    $scope.$watch 'newTrack.name', (_searchText) ->
      if (!_searchText || _searchText.length == 0)
        $scope.results = {}
        return
      else if _searchText == $scope.newTrack.name
        $scope.searchForVideos()

    $scope.searchForVideos = ->
      if $scope.newTrack.name.length > 3
        request = gapi.client.youtube.search.list
          q: $scope.newTrack.name
          part: 'snippet'
          type: 'video'

        request.execute (res) ->
          $scope.$apply ->
            $scope.results = res.result.items
