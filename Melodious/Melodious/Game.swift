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
    case GameIsBeingCreated = 0
    case GameIsWaitingForAnswer
    case GameIsWaitingforOpponent
    case GameIsWaitingForJudge
    
}

class Game: PFObject, PFSubclassing {
    
    class func parseClassName() -> String {
        return "Game"
    }
    
    @NSManaged var gameState: NSNumber!
    @NSManaged var challenger: PFUser!
    @NSManaged var opponent: PFUser!
    @NSManaged var challengerSongURL: [NSString: String]!
    @NSManaged var opponentSongURL: [NSString: String]!
    @NSManaged var winner: String!
    @NSManaged var loser: String!
   
}

