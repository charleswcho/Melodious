//
//  ScoreCell.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/6/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class ScoreCell: UITableViewCell {

    @IBOutlet weak var opponentNameLabel: UILabel!
    @IBOutlet weak var opponentScoreLabel: UILabel!
    @IBOutlet weak var currentUserScoreLabel: UILabel!
    @IBOutlet var opponentProfilePic: FBSDKProfilePictureView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setGame(inputGame: Game) {
        
        opponentNameLabel.text = inputGame.player2.name
//        opponentScoreLabel.text = inputGame.opponent.
//        currentUserScoreLabel.text = inputGame.challenger.
        
        var facebookID = inputGame.player2.facebookID
        
        // Get user profile pic
        opponentProfilePic.profileID = facebookID
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
