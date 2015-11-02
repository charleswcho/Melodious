//
//  ProfileCell.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/6/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import ParseFacebookUtilsV4

class ProfileCell: UITableViewCell {

    @IBOutlet weak var currentUserNameLabel: UILabel!
    @IBOutlet weak var currentUserWLabel: UILabel!
    @IBOutlet weak var currentUserLLabel: UILabel!
    @IBOutlet weak var currentUserTLabel: UILabel!
    @IBOutlet var currentUserProfilePic: FBSDKProfilePictureView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        currentUserNameLabel.text = User.currentUser()?.name
        
        if User.currentUser()?.wins == nil {
            // Set default scores to 0
            User.currentUser()?.wins = 0
            User.currentUser()?.losses = 0
            User.currentUser()?.ties = 0
            
            User.currentUser()?.saveInBackground()
            
            currentUserWLabel.text = "0"
            currentUserLLabel.text = "0"
            currentUserTLabel.text = "0"
            
        } else {
            
            currentUserWLabel.text = User.currentUser()?.wins.stringValue
            currentUserLLabel.text = User.currentUser()?.losses.stringValue
            currentUserTLabel.text = User.currentUser()?.ties.stringValue
        }

        
        // Get user profile pic
        currentUserProfilePic.profileID = User.currentUser()!.facebookID

    }
    
 

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
