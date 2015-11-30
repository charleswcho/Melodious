// Save W/L/T count to Users



Parse.Cloud.define('addWinsLosses', function(request,responce) {
	
	Parse.Cloud.useMasterKey();

	var winnerUserId = request.params.winnerUserId, 
		loserUserId = resquest.params.loserUserId

	var User = Parse.Object.extend('_User'),
		winner = new User({ objectId: winnerUserId });

	winner.set('wins', 1)

	winner.Save().then(function(winner) {
		responce.success(winner);
	}, 

	function(error) {
		responce.error(error)
	});

	var User = Parse.Object.extend('_User'),
		loser = new User({ objectId: loserUserId });

	loser.set('losses', 1)

	loser.Save().then(function(loser) {
		responce.success(loser);
	}, 

	function(error) {
		responce.error(error)
	});
});

Parse.Cloud.define('addTie', function(request,responce) {
	
	Parse.Cloud.useMasterKey();

	var player1UserId = request.params.player1UserId, 
		player2UserId = resquest.params.player2UserId

	var User = Parse.Object.extend('_User'),
		player1 = new User({ objectId: player1UserId });

	player1.set('ties', 1)

	player1.Save().then(function(player1) {
		responce.success(player1);
	}, 

	function(error) {
		responce.error(error)
	});

	var User = Parse.Object.extend('_User'),
		player2 = new User({ objectId: player2UserId });

	player2.set('ties', 1)
	
	player2.Save().then(function(player2) {
		responce.success(player2);
	}, 

	function(error) {
		responce.error(error)
	});

});