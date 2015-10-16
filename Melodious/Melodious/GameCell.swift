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
    
    func updateView() {
        
        opponentNameLabel.text = self.game.opponent.name
        
        // Get user profile pic
        opponentProfilePic.profileID = self.game.opponent.facebookID
        
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
