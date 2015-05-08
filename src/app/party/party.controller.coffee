angular.module "jkbx"
  .controller "PartyCtrl", ($scope, $stateParams, $firebaseArray) ->
    ref = new Firebase("https://jkbx.firebaseio.com/party/#{$stateParams.name}/tracks")

    $scope.party = $stateParams.name
    $scope.newTrack = {}
    $scope.tracks = $firebaseArray(ref)

    $scope.addTrack = (form) ->
      $scope.tracks.$add
        title: $scope.newTrack.name

    $scope.removeTrack = (track, index) ->
      $scope.tracks.$remove(index)
