//
//  User.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/6/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import Foundation
import Parse
import FBSDKCoreKit

class User: PFUser {
 
    @NSManaged var facebookID: String!
    @NSManaged var name: String!
    @NSManaged var wins: NSNumber!
    @NSManaged var losses: NSNumber!
    @NSManaged var ties: NSNumber!
    @NSManaged var points: NSNumber!
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let user = object as? User {
            
            if self.objectId! == user.objectId {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func returnUserData() {    // Get Facebook info from current User
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil) {
                // Process error
                print("Error: \(error)")
            } else {
                
                print("fetched user: \(result)")
                
                let currentUserName = result.valueForKey("name") as! String
                let currentUserFBID = result.valueForKey("id") as! String
                
                User.currentUser()?.name = currentUserName
                User.currentUser()?.facebookID = currentUserFBID as String
                
                
                if User.currentUser()?.points == nil {
                    User.currentUser()?.points = 6
                    
                }
                
                User.currentUser()?.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                    if success {
                        NSLog("Current User name and fbID saved")
                    } else {
                        NSLog("%@", error!)
                    }
                })
            }
        })
    }
    
    func getUsersFriends(block: PFQueryArrayResultBlock?) {
        FBSDKGraphRequest(graphPath: "me/friends", parameters: ["fields":"id"]).startWithCompletionHandler ({ (connection, result, error) -> Void in
            if result != nil {
                let r = result as! NSDictionary
                let list = r["data"] as! NSArray
                print("\(list) friends")
                let idArray : [String] = list.map({$0["id"] as! String })
                let query = User.query()!
                query.whereKey("facebookID", containedIn: idArray)
                query.findObjectsInBackgroundWithBlock(block)
            }
        })
    }
    
    
    
}
