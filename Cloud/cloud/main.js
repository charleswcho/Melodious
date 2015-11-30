// Save W/L/T count to Users



Parse.Cloud.define('addWinsLosses', function(request,response) {
	
	Parse.Cloud.useMasterKey();

	var winnerUserId = request.params.winnerUserId, 
		loserUserId = request.params.loserUserId

	var User = Parse.Object.extend('_User'),
		winner = new User({ objectId: winnerUserId });

	winner.increment('wins')

	winner.save(null, {
	    success: function (winner) {
	        response.success();
	    },
	    error: function (error) {
	        response.error(error);
    	}
	});

	loser = new User({ objectId: loserUserId });

	loser.increment('losses')

	loser.save(null, {
	    success: function (loser) {
	        response.success();
	    },
	    error: function (error) {
	        response.error(error);
    	}
	});
});

Parse.Cloud.define('addTie', function(request,response) {
	
	Parse.Cloud.useMasterKey();

	var player1UserId = request.params.player1UserId, 
		player2UserId = request.params.player2UserId

	var User = Parse.Object.extend('_User'),
		player1 = new User({ objectId: player1UserId });

	player1.increment('ties')

	player1.save(null, {
	    success: function (player1) {
	        response.success();
	    },
	    error: function (error) {
	        response.error(error);
    	}
	});

	var User = Parse.Object.extend('_User'),
		player2 = new User({ objectId: player2UserId });

	player2.increment('ties')
	
	player2.save(null, {
	    success: function (player2) {
	        response.success();
	    },
	    error: function (error) {
	        response.error(error);
    	}
	});

});