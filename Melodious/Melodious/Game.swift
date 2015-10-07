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

class Game: PFObject, PFSubclassing {
    
    class func parseClassName() -> String {
        return "Game"
    }
    
    @NSManaged var gameState: NSNumber!
    @NSManaged var challenger: User!
    @NSManaged var opponent: User!
    @NSManaged var challengerSongURL: [NSString: String]!
    @NSManaged var opponentSongURL: [NSString: String]!
    @NSManaged var winner: String!
    @NSManaged var loser: String!
   
}

// Initialize empty arrays that will store game objects of 
var gameState1Array : NSMutableArray = []
var gameState2Array : NSMutableArray = []
var gameState3Array : NSMutableArray = []
var gameState4Array : NSMutableArray = []

func fetchData() {
    // Querying data from Parse
    
    var gamesAsChallenger = PFQuery(className: "Game")
    gamesAsChallenger.whereKey("challenger", equalTo: PFUser.currentUser()!)
    
    var gamesAsOpponent = PFQuery(className: "Game")
    gamesAsOpponent.whereKey("opponent", equalTo: PFUser.currentUser()!)
    
    var query : PFQuery = PFQuery.orQueryWithSubqueries([gamesAsChallenger, gamesAsOpponent])

    query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]?, error: NSError?) -> Void in
        
        if(error == nil){
            
            // objects = An array of all game objects that have the .currentUser() in it
            
            if let gameObjects = objects as? [Game] {     // Safe unpacking of array

                for game : Game in gameObjects {
                    
                    switch game.gameState {   // Seperate game objects by game state (Other option multiple queries?)
                    
                    case 1:
                        gameState1Array.addObject(game)
                        
                    case 2:
                        gameState2Array.addObject(game)
                        
                    case 3:
                        gameState3Array.addObject(game)
                        
                    case 4:
                        gameState4Array.addObject(game)
                        
                    default:
                        println("No game arrays available")
                    }
                }
            }
        }
            
        else{
            println("Error in retrieving \(error)")
        }
        
    })
    
}
