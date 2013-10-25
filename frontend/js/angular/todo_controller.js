var todoApp = angular.module('TodoApp', []);

todoApp.config(function($httpProvider) {
  $httpProvider.defaults.useXDomain = true;
  delete $httpProvider.defaults.headers.common['X-Requested-With'];
});

todoApp.controller('TodoController', function TodoController($scope, $http) {
    $http.get('/api/todo/1').success(function(data) {
	$scope.todos = data;
	console.log("ok", data);
    });

    $scope.post = function() {
	$http.post('/api/todo').success(function(data) {
	    console.log("ok", data);
	}).error(function (data) {
	    console.log("error", data)
	});
    };
});
