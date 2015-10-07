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
    case GameIsBeingCreated = 1
    case GameIsWaitingForAnswer
    case GameIsWaitingforOpponent
    case GameIsWaitingForJudge
    // More game states needed? "JudgesHaveScored""GameHasEnded"
}
//WaitingForAcceptance  //trying to find partner or waiting for acceptance
//WaitingForJudgment
//Finished

class Game: PFObject, PFSubclassing {
    
    class func parseClassName() -> String {
        return "Game"
    }
    
    @NSManaged var stateValue: NSNumber!
    @NSManaged var player1: User!
    @NSManaged var player2: User!
    @NSManaged var player1SongURL: String!
    @NSManaged var player2SongURL: String!
    @NSManaged var winner: String!
    @NSManaged var loser: String!
    
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
    
    
    // MARK: Parse
    
    // Fetch data from Parse
    
    typealias GameResultsBlock = (objects:[[Game]]?, success:Bool) -> Void

    class func fetchData(resultBlock: GameResultsBlock) {
        // Querying data from Parse
        // Initialize empty arrays that will store game objects of
        var gameState1Array : [Game] = []
        var gameState2Array : [Game] = []
        var gameState3Array : [Game] = []
        var gameState4Array : [Game] = []
        
        let gamesArray = [gameState1Array, gameState2Array, gameState3Array, gameState4Array]
        
        
        var gamesAsChallenger = PFQuery(className: "Game")
        gamesAsChallenger.whereKey("challenger", equalTo: PFUser.currentUser()!)
        
        var gamesAsOpponent = PFQuery(className: "Game")
        gamesAsOpponent.whereKey("opponent", equalTo: PFUser.currentUser()!)
        
        var query : PFQuery = PFQuery.orQueryWithSubqueries([gamesAsChallenger, gamesAsOpponent])
        
        query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if(error == nil){
                
                // objects = An array of all game objects that have the .currentUser() in it
                
                if let gameObjects = objects as? [Game] {     // Safe unpacking of array
                    
                    for game in gameObjects {
                        var array = gamesArray[self.state.rawValue-1]
                        array.append(game)
                    }
                }
            }
                
            else{
                println("Error in retrieving \(error)")
            }
            
        })
        
    }

}



