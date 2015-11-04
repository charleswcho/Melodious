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
    case stateWaitingForAcceptance = 0 //trying to find partner or waiting for acceptance
    case stateWaitingForJudgment
    case stateFinished
    // More game states needed? "JudgesHaveScored""GameHasEnded"
    
    // Change enums to have "state" before
}

class Game: PFObject, PFSubclassing {
    
    class func parseClassName() -> String {
        return "Game"
    }
    
    @NSManaged var gameState: NSNumber!
    @NSManaged var player1: User!
    @NSManaged var player2: User!
    @NSManaged var player1Scores: [Int]!
    @NSManaged var player2Scores: [Int]!
    @NSManaged var player1SongID: String!
    @NSManaged var player2SongID: String!
    @NSManaged var player1SongDetails: [String]!
    @NSManaged var player2SongDetails: [String]!
    @NSManaged var judges: [User]!


    
    var state : GameState {
        get {
            return GameState(rawValue: gameState.integerValue)!
        }
    }
   
    var currentUser : User! {
        return User.currentUser()
    }
    
    var opponent : User! {
        if player1.isEqual(User.currentUser()) {
            return player2
        } else {
            return player1
        }
    }

    var myTotalScore : Int {
        if player1.isEqual(User.currentUser()!) {
            return player1Scores.reduce(0, combine: +)
        } else {
            return player2Scores.reduce(0,combine: +)
        }
    }
    
    var opponentTotalScore : Int {
    
        if !player1.isEqual(User.currentUser()!) {
            return player1Scores.reduce(0, combine: +)
        } else {
            return player2Scores.reduce(0,combine: +)
        }
    }
    
    var mySongID : String! {
        if player1.isEqual(User.currentUser()!) {
            return player1SongID
        } else {
            return player2SongID
        }
    }
    
    var opponentSongID : String! {
        if !player1.isEqual(User.currentUser()!) {
            return player1SongID
        } else {
            return player2SongID
        }
    }
    
    var mySongDetails : [String]! {
        if player1.isEqual(User.currentUser()!) {
            return player1SongDetails
        } else {
            return player2SongDetails
        }
    }
    
    var opponentSongDetails : [String]! {
        if !player1.isEqual(User.currentUser()!) {
            return player1SongDetails
        } else {
            return player2SongDetails
        }
    }
    
    var winner : User? {
        
        if myTotalScore > opponentTotalScore {
            return currentUser
        
        } else if myTotalScore == opponentTotalScore {
            return nil
            
        } else {
            return opponent
        }
    }
    
    // MARK: Parse
    
    // Fetch Games from Parse
    
    typealias GameResultsBlock = (games:[[Game]]?, error:NSError?) -> Void
    
    class func fetchData(resultBlock: GameResultsBlock) {

        // Initialize empty arrays that will store game objects of different game states
        
        var waitingForOpponentArray : [Game] = []
        var challengesWaitingForAnswerArray : [Game] = []
        var waitingForJudgesArray : [Game] = []
        var completedGamesArray : [Game] = []
        
        if User.currentUser() != nil {
            
            let gamesAsChallenger = PFQuery(className: "Game")
            gamesAsChallenger.whereKey("player1", equalTo: User.currentUser()!)
            
            let gamesAsOpponent = PFQuery(className: "Game")
            gamesAsOpponent.whereKey("player2", equalTo: User.currentUser()!)

            let query : PFQuery = PFQuery.orQueryWithSubqueries([gamesAsChallenger, gamesAsOpponent])
            query.includeKey("player1")
            query.includeKey("player2")
            
            query.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
                
                if(error == nil){
                    
                    // objects = An array of all game objects that have the .currentUser() in it
                    
                    if let gameObjects = objects as? [Game] {     // Safe unpacking of array
                        
                        for game in gameObjects {
                            
                            if game.state == .stateWaitingForAcceptance {
                                
                                if game.player1.isEqual(User.currentUser()) { // Perspective of the challenger
                                    
                                    waitingForOpponentArray.append(game)
                                    
                                } else { // Perspective of the challenged opponent
                                    
                                    challengesWaitingForAnswerArray.append(game)
                                    
                                }
                                
                            } else {
                                
                                if game.state == .stateWaitingForJudgment {
                                    
                                    waitingForJudgesArray.append(game)
                                    
                                } else if game.state == .stateFinished {
                                    
                                    completedGamesArray.append(game)
                                    
                                }
                            
                            }
                            
                            let gamesArray = [challengesWaitingForAnswerArray, waitingForOpponentArray, waitingForJudgesArray, completedGamesArray]
                            
                            resultBlock(games: gamesArray, error:nil);
                            
                        }
                    }
                }
                    
                else {
                    resultBlock(games: nil, error:error);
                    
                    print("Error in retrieving \(error)")
                }
                
            })
            
        } else {
            print("No User logged in")
        }
        
    }

}



