'use strict';
angular.module('clientApp')
  .controller('MainCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
    $scope.clickIng = function() {
      console.log('clicking');
      $scope.fc = $scope.fc + 1;
    };
    $scope.moving = function(event) {
      if ($scope.down) {
        $scope.clientX = event.clientX;
        $scope.clientY = event.clientY;
        $scope.offsetX = event.offsetX;
        $scope.offsetY = event.offsetY;
        $scope.pageX = event.pageX;
        $scope.pageY = event.pageY;
        $scope.screenX = event.screenX;
        $scope.screenY = event.screenY;
      }
    };
  });
