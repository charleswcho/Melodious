//
//  User.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/6/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import Foundation
import Parse

class User: PFUser, PFSubclassing {
 
    @NSManaged var facebookID: String!
    @NSManaged var name: String!
    @NSManaged var wins: NSNumber!
    @NSManaged var losses: NSNumber!
    @NSManaged var ties: NSNumber!
    @NSManaged var loser: String!
    

}
