// Things of interest.
//
// console.log('onTouchMove');
// console.log(event);

// console.log('layerX: ' + event.layerX);
// console.log('layerY: ' + event.layerY);
// console.log('pageX: ' + event.pageX);
// console.log('pageY: ' + event.pageY);
// console.log('touches: ' + event.touches);

// var touches = event.touches[0];

// console.log('touches.clientX: ' + touches.clientX);
// console.log('touches.clientY: ' + touches.clientY);
// console.log('touches.pageX: ' + touches.pageX);
// console.log('touches.pageY: ' + touches.pageY);
// console.log('touches.screenX: ' + touches.screenX);
// console.log('touches.screenY: ' + touches.screenY);

var module = angular.module('clientApp');
  module.directive('fingers', ['$parse', '$document', '$http',
                      function ($parse, $document, $http) {
    var document = angular.element($document);
    var fn, initX, initY, endX, endY;
    var maxMove = 4;

    return {
      restrict: 'A',
      link: function (scope, element, attr) {
        var x, y, doClick;
        fn = $parse(attr['fingersClicked']);

        document.bind('touchstart', function(event){
          event.preventDefault();
          event = event.originalEvent;
          x = event.pageX;
          y = event.pageY;

          initX = endX = event.pageX;
          initY = endY = event.pageY;
          doClick = true;
        });

        document.bind('touchmove', function(event) {
          event = event.originalEvent;
          var offsetX = x - event.pageX,
              offsetY = y - event.pageY;
          x = event.pageX;
          y = event.pageY;


          endX = event.pageX;
          endY = event.pageY;

          if (doClick) {
            if (Math.abs(endX - initX) > maxMove) {
              doClick = false;
            }
            if (Math.abs(endY - initY) > maxMove) {
              doClick = false;
            }
          }

          scope.$apply(function() {
            scope.y = y;
            scope.x = x;
            scope.offsetX = offsetX;
            scope.offsetY = offsetY;
          });

          $http.post('/move', {
            'x':x,
            'y':y,
            'offsetX':offsetX,
            'offsetY':offsetY
          });
        });

        document.bind('touchend', function(event) {
          if (doClick) {
            $http.post('/click');
            scope.$apply(function() { fn(scope, { $event: event }); });
          }
        });
      }
    };
  }]);

