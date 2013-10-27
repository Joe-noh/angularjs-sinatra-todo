todoApp.controller('TodoController', function TodoController($scope, $http) {
    $scope.submitPost = function() {
	console.log($scope.todo);
	$http({
	    method: 'POST',
	    url: '/api/todos',
	    params: $scope.todo
	}).success(function(todo) {
	    console.log("ok", todo);
	    $scope.reload();
	});
	$scope.todo.body = ""
    };

    $scope.reload = function() {
	$http.get('/api/todos').success(function(todos) {
	    $scope.todos = todos;
	    console.log("ok", todos);
	});
    }

    $scope.deleteTodo = function(todo) {
	$http.delete('/api/todo/'+todo.id).success(function(todos) {
	    $scope.reload();
	});
    };

    $scope.toggleDone = function(todo) {
	todo.done = !todo.done;
	$http({
	    method: 'PUT',
	    url: '/api/todo/'+todo.id,
	    params: todo
	}).success(function() {
	    $scope.reload();
	});
    };

});
