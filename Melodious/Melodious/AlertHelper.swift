//
//  AlertHelper.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 11/16/15.
//  Copyright © 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class AlertHelper: NSObject {
    
    // MARK: HomeTVC
    
    static func noInternetConnection() -> UIAlertController {
        
        let alertController = UIAlertController(title: "Alert", message: "No internet connection!", preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            
        }
        
        alertController.addAction(OKAction)
        
        return alertController
        
    }
    
    static func notEnoughPointsAlert() -> UIAlertController {
        
        let alertController = UIAlertController(title: "Alert", message: "You don't have enough points to play a game! Go judge some games!", preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            
        }
        
        alertController.addAction(OKAction)
        
        return alertController
        
    }
    
    static func trashButtonPressedAlert(games: [Game]) -> UIAlertController {
        
        let alertController = UIAlertController(title: "Alert", message: "Do you want to delete all recent games?", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            
        }
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            
            for game in games {
                game.deleteInBackgroundWithBlock({ (success, error) -> Void in
                    if error == nil {
                        
                        print("Did delete game? \(success)")
                        
                        // Create notification that homeTVC needs to be reloaded
                        
                        print("Home Table needs to reload")
                        
                        NSNotificationCenter.defaultCenter().postNotificationName(homeTableNeedsReloadingNotification, object: self)
                        
                    } else {
                        
                        print("Error: \(error)")
                        
                    }
                })
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(OKAction)
        
        return alertController
        
    }
    
    // JudgingVC
    
    static func waitForTimerAlert() -> UIAlertController {
        
        let alertController = UIAlertController(title: "Alert", message: "Listen to the song!", preferredStyle: .Alert)
        
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            
        }
        
        alertController.addAction(OKAction)
        
        return alertController
        
    }

}
