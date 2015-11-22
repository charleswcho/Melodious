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
    @IBOutlet weak var myScoreLabel: UILabel!
    @IBOutlet weak var opponentScoreLabel: UILabel!
    @IBOutlet weak var winnerLoserLabel: UILabel!
    
    var game : Game! {
        didSet {
            self.updateView()
        }
    }
    
    func updateView() {
        
        if self.game != nil {
            
            if game.player1Scores.isEmpty && game.player2Scores.isEmpty {
            
                myScoreLabel.text = "0"
            }
            
            myScoreLabel?.text = String(game.myTotalScore)
            
            if game.opponent == nil {
                
                opponentNameLabel.text = "Random opponent"
                opponentProfilePic.profileID = nil
                opponentScoreLabel.text = "?"
                
            } else {
                
                opponentNameLabel.text = game.opponent.name!
                opponentProfilePic.profileID = game.opponent.facebookID!
                opponentScoreLabel.text = String(game.opponentTotalScore)
            }
       
        } else {
            
            print("Error: No games or users")
        }
 
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        opponentProfilePic.layer.cornerRadius = opponentProfilePic.frame.size.width / 2
        opponentProfilePic.layer.borderColor = UIColor.lightGrayColor().CGColor
        opponentProfilePic.layer.borderWidth = 1.0
        opponentProfilePic.clipsToBounds = true

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
