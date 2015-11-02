//
//  GameCell.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/16/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class GameCell: UITableViewCell {

    @IBOutlet weak var opponentNameLabel: UILabel!
    @IBOutlet var opponentProfilePic: FBSDKProfilePictureView!
    
    var game : Game! {
        didSet {
            self.updateView()
        }
    }
    
    var friend : User! {
        didSet {
            self.updateView()
        }
    }
    
    func updateView() {
        
        if (self.game == nil && self.friend != nil || self.game != nil && self.friend != nil) {
            opponentNameLabel.text = self.friend.name
            opponentProfilePic.profileID = self.friend.facebookID
            
        } else if (self.game != nil && self.friend == nil || self.game != nil && self.friend != nil) {
            
            opponentNameLabel.text = self.game.opponent.name
            // Get user profile pic
            opponentProfilePic.profileID = self.game.opponent.facebookID
            
        } else {
            
            print("Error: No games or users")
        }
 
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
