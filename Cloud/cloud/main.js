// Save W/L/T count to Users

Parse.Cloud.define('addWinsLosses', function(request,response) { 

    Parse.Cloud.useMasterKey(); 

    var winnerUserId = request.params.winnerUserId;
    var loserUserId = request.params.loserUserId;

    var User = Parse.Object.extend('_User');
    var winner = new User({ objectId: winnerUserId });
    var loser = new User({ objectId: loserUserId });

	console.log(JSON.stringify(winner));
	console.log(JSON.stringify(loser));

    winner.increment('wins');
    loser.increment('losses');
    
    Parse.Promise.when([winner.save(), loser.save()]).then(function () {
        // both saves have completed
        response.success();
    }, function (error) {
        // one or more errors
        console.log("Error in addWinsLosses : " + error.message);
        response.error(error);
    });
});


Parse.Cloud.define('addTie', function(request,response) {

	Parse.Cloud.useMasterKey();

	var player1Id = request.params.player1Id;
	var player2Id = request.params.player2Id;

	var User = Parse.Object.extend('_User');
	var player1 = new User({ objectId: player1Id })
	var player2 = new User({ objectId: player2Id })

	console.log(JSON.stringify(player1));
	console.log(JSON.stringify(player2));

	player1.increment('ties');
	player2.increment('ties');

	Parse.Promise.when([player1.save(), player2.save()]).then(function () {

		response.success();
	}, function (error) {

		console.log("Error in addTie : " + error.message);
		response.error(error);
	});
});