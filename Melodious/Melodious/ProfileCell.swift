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
        // Initialization code
    }
    
    func setGame(inputGame: Game) {
        
        currentUserLLabel.text = inputGame.player1.name
        currentUserWLabel.text = inputGame.player1.wins.stringValue
        currentUserLLabel.text = inputGame.player1.losses.stringValue
        currentUserTLabel.text = inputGame.player1.ties.stringValue
        
        var facebookID = inputGame.player1.facebookID
        
        // Get user profile pic
        currentUserProfilePic.profileID = facebookID        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
