angular.module "jkbx"
  .controller "MainCtrl", ($scope, $state) ->

    $scope.findOrCreateRoom = ->
      $state.go 'party', {name: $scope.roomName}

