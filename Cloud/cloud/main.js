// Save W/L/T count to Users



Parse.Cloud.define('editUser', function(request,responce) {

	var userId = request.params.userId, 
		wins = request.params.wins;


	var User = Parse.Object.extend('_User'),
		user = new User({ objectId: userId });

	user.set('wins', wins)

	Parse.Cloud.useMasterKey();
	user.Save().then(function(user) {
		responce.success(user);
	}, function(error) {
		responce.error(error)
	});

});