todoApp.controller('TodoController', function TodoController($scope, $http) {
    $scope.submitPost = function() {
	console.log($scope.todo);
	$http({
	    method: 'POST',
	    url: '/api/todos',
	    params: $scope.todo
	}).success(function(todo) {
	    console.log("ok", todo);
	});
	$scope.todo.body = ""
	$scope.reload();
    };

    $scope.reload = function() {
	$http.get('/api/todos').success(function(todos) {
	    $scope.todos = todos;
	    console.log("ok", todos);
	});
    }

    $scope.deleteTodo = function(id) {
	$http.delete('/api/todo/'+id).success(function(todos) {
	    $scope.reload();
	});
    };

    $scope.reload();
});
