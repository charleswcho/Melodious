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
    
    var winnerPushQuery = new Parse.Query(Parse.Installation);
    
    winnerPushQuery.equalTo('user', winner);

    var winnerPushPromise = Parse.Push.send({
        where: winnerPushQuery,
        data: {
            alert: "You lost.",
            badge: "increment",
        }
    })

    var loserPushQuery = new Parse.Query(Parse.Installation);
    
    loserPushQuery.equalTo('user', loser);

    var loserPushPromise = Parse.Push.send({
        where: loserPushQuery,
        data: {
            alert: "You lost.",
            badge: 'increment',
        }
    })

    var promises = [winnerPushPromise, loserPushPromise, winner.save(), loser.save()]

    Parse.Promise.when(promises).then(function () {
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