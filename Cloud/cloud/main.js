// Save W/L/T count to Users



Parse.Cloud.define('addWinsLosses', function(request,responce) {
	
	Parse.Cloud.useMasterKey();

	var winnerUserId = request.params.winnerUserId, 
		loserUserId = resquest.params.loserUserId

	var User = Parse.Object.extend('_User'),
		winner = new User({ objectId: winnerUserId });

	winner.set('wins', 1)

	winner.save(null, {
	    success: function (winner) {
	        response.success();
	        console.log("Save ok");
	    },
	    error: function (error) {
	        response.error(error);
	        console.log("Save ko");
    	}
	});

	var User = Parse.Object.extend('_User'),
		loser = new User({ objectId: loserUserId });

	loser.set('losses', 1)

	loser.save(null, {
	    success: function (loser) {
	        response.success();
	        console.log("Save ok");
	    },
	    error: function (error) {
	        response.error(error);
	        console.log("Save ko");
    	}
	});
});

Parse.Cloud.define('addTie', function(request,responce) {
	
	Parse.Cloud.useMasterKey();

	var player1UserId = request.params.player1UserId, 
		player2UserId = resquest.params.player2UserId

	var User = Parse.Object.extend('_User'),
		player1 = new User({ objectId: player1UserId });

	player1.set('ties', 1)

	player1.save(null, {
	    success: function (player1) {
	        response.success();
	        console.log("Save ok");
	    },
	    error: function (error) {
	        response.error(error);
	        console.log("Save ko");
    	}
	});

	var User = Parse.Object.extend('_User'),
		player2 = new User({ objectId: player2UserId });

	player2.set('ties', 1)
	
	player2.save(null, {
	    success: function (player2) {
	        response.success();
	        console.log("Save ok");
	    },
	    error: function (error) {
	        response.error(error);
	        console.log("Save ko");
    	}
	});

});