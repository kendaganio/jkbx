angular.module "jkbx"
  .controller "MainCtrl", ($scope, $firebaseObject) ->

    ref = new Firebase("https://jkbx.firebaseio.com/")

    syncObj = $firebaseObject(ref)
    syncObj.$bindTo $scope, 'data'
