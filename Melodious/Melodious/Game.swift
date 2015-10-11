//
//  Game.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/5/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import Foundation
import Parse

enum GameState : Int {
    case WaitingForAcceptance = 0 //trying to find partner or waiting for acceptance
    case WaitingForJudgment
    case Finished
    // More game states needed? "JudgesHaveScored""GameHasEnded"
    
    // Change enums to have "state" before
}

class Game: PFObject, PFSubclassing {
    
    class func parseClassName() -> String {
        return "Game"
    }
    
    @NSManaged var stateValue: NSNumber!
    @NSManaged var player1: User!
    @NSManaged var player2: User!
    @NSManaged var player1SongURL: String!
    @NSManaged var player2SongURL: String!
    @NSManaged var winner: User!
    @NSManaged var loser: User!
    @NSManaged var judges: [User]!
    @NSManaged var judgesScoresForPlayer1: [NSNumber]!
    @NSManaged var judgesScoresForPlayer2: [NSNumber]!

    
    var state : GameState {
        get {
            return GameState(rawValue: stateValue.integerValue)!
        }
    }
   
    var mySongURL : String! {
        if player1 == User.currentUser() {
            return player1SongURL
        } else {
            return player2SongURL
        }
    }
    
    var opponentSongURL : String! {
        if player1 != User.currentUser() {
            return player1SongURL
        } else {
            return player2SongURL
        }
    }
    
//    var player1TotalScore : NSNumber {
//        
//        return judgesScoresForPlayer1.reduce(0, +)
//    }
//    
//    var player2TotalScore : NSNumber {
//        
//        return judgesScoresForPlayer2.reduce(0,+)
//    }
    
    
    // MARK: Parse
    
    // Fetch data from Parse
    
    typealias GameResultsBlock = (games:[[Game]]?, error:NSError?) -> Void  // Is this the correct syntax?

    class func fetchData(resultBlock: GameResultsBlock) {

        // Initialize empty arrays that will store game objects of different game states
        
        var waitingForOpponentArray : [Game] = []
        var challengesWaitingForAnswerArray : [Game] = []
        var waitingForJudgesArray : [Game] = []
        var completedGamesArray : [Game] = []
        
        if User.currentUser() != nil {
            
            var gamesAsChallenger = PFQuery(className: "Game")
            gamesAsChallenger.whereKey("player1", equalTo: User.currentUser()!)
            
            var gamesAsOpponent = PFQuery(className: "Game")
            gamesAsOpponent.whereKey("player2", equalTo: User.currentUser()!)

            var query : PFQuery = PFQuery.orQueryWithSubqueries([gamesAsChallenger, gamesAsOpponent])
            
            query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]?, error: NSError?) -> Void in
                
                if(error == nil){
                    
                    // objects = An array of all game objects that have the .currentUser() in it
                    
                    if let gameObjects = objects as? [Game] {     // Safe unpacking of array
                        
                        for game in gameObjects {
                            
                            if game.state == .WaitingForAcceptance {
                                
                                if game.player1 == User.currentUser() { // Perspective of the challenger
                                    
                                    waitingForOpponentArray.append(game)
                                    
                                } else { // Perspective of the challenged opponent
                                    
                                    challengesWaitingForAnswerArray.append(game)
                                    
                                }
                                
                            } else {
                                
                                if game.state == .WaitingForJudgment {
                                    
                                    waitingForJudgesArray.append(game)
                                    
                                } else if game.state == .Finished {
                                    
                                    completedGamesArray.append(game)
                                    
                                }
                                
                                let gamesArray = [waitingForOpponentArray, challengesWaitingForAnswerArray, waitingForJudgesArray, completedGamesArray]
                                
                                resultBlock(games: gamesArray, error:nil);
                                //                            var array = gamesArray[game.state.rawValue-1]
                                //                            array.append(game)
                                
                            }
                        }
                    }
                }
                    
                else{
                    resultBlock(games: nil, error:error);
                    
                    println("Error in retrieving \(error)")
                }
                
            })
            
        } else {
            println("No User logged in")
        }
        
    }

}



