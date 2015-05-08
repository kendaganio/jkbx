angular.module "jkbx"
  .controller "PlayerCtrl", ($scope, $stateParams, $firebaseArray) ->
    ref = new Firebase("https://jkbx.firebaseio.com/party/#{$stateParams.name}/tracks")

    $scope.newTrack = {}
    $scope.tracks = $firebaseArray(ref)

    $scope.addTrack = (form) ->
      $scope.tracks.$add
        title: $scope.newTrack.name
