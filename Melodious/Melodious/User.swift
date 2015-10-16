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
    
}
