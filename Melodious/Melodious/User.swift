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

class User: PFUser, PFSubclassing {
 
    @NSManaged var facebookID: String!
    @NSManaged var name: String!
    @NSManaged var wins: NSNumber!
    @NSManaged var losses: NSNumber!
    @NSManaged var ties: NSNumber!
    
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
    
//    func getFriendsList() {
//        
//        // Get List Of Friends
//        
//        
//        var friendsRequest : FBRequest = FBRequest.requestForMyFriends()
//        friendsRequest.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
//            var resultdict = result as NSDictionary
//            println("Result Dict: \(resultdict)")
//            var data : NSArray = resultdict.objectForKey("data") as NSArray
//            
//            for i in 0..&lt;data.count {
//                let valueDict : NSDictionary = data[i] as NSDictionary
//                let id = valueDict.objectForKey("id") as String
//                println("the id value is \(id)")
//            }
//            
//            var friends = resultdict.objectForKey("data") as NSArray
//            println("Found \(friends.count) friends")
//        }
//        
//    }
    
}
