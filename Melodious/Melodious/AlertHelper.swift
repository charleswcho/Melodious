//
//  AlertHelper.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 11/16/15.
//  Copyright © 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class AlertHelper: NSObject {
    
    static func notEnoughPointsAlert() -> UIAlertController {
        
        let alertController = UIAlertController(title: "Alert", message: "You don't have enough points to play a game! Go judge some games!", preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            
        }
        
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
