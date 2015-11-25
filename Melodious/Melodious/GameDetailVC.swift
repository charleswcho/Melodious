//
//  GameDetailVC.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/16/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit
import FBSDKCoreKit


class GameDetailVC: UIViewController {
    
    @IBOutlet var opponentProfilePic: FBSDKProfilePictureView!
    @IBOutlet weak var opponentNameLabel: UILabel!
    @IBOutlet weak var opponentTotalScore: UILabel!
    @IBOutlet var opponentVideo: YTPlayerView!
    @IBOutlet var opponentVideoName: UILabel!
    @IBOutlet var opponentVideoChannel: UILabel!
    @IBOutlet var opponentVideoViewCount: UILabel!
    
    @IBOutlet var currentUserProfilePic: FBSDKProfilePictureView!
    @IBOutlet weak var currentUserTotalScore: UILabel!
    @IBOutlet var currentUserVideo: YTPlayerView!
    @IBOutlet var currentUserVideoName: UILabel!
    @IBOutlet var currentUserVideoChannel: UILabel!
    @IBOutlet var currentUserVideoViewCount: UILabel!
    
    @IBOutlet weak var opponentStackView: UIStackView!
    
    var game : Game! {
        didSet {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setOpponent()
        setCurrentUser()

        // Create corners and borders
        opponentProfilePic.layer.cornerRadius = opponentProfilePic.frame.size.width / 2
        opponentProfilePic.layer.borderColor = UIColor.lightGrayColor().CGColor
        opponentProfilePic.layer.borderWidth = 1.0
        opponentProfilePic.clipsToBounds = true
        
        currentUserProfilePic.layer.cornerRadius = currentUserProfilePic.frame.size.width / 2
        currentUserProfilePic.layer.borderColor = UIColor.lightGrayColor().CGColor
        currentUserProfilePic.layer.borderWidth = 1.0
        currentUserProfilePic.clipsToBounds = true
    }

    func setOpponent() {
        
        opponentProfilePic.profileID = game.opponent?.facebookID
        
//        print(game.opponent.facebookID)
        
        opponentTotalScore.text = String(game.opponentTotalScore)

        if game.opponent?.name != nil {
            
            opponentNameLabel.text = game.opponent.name

        } else if game.opponent == nil {
            
            opponentNameLabel.text = "Random Opponent"
            
        } else  {
            
            opponentNameLabel.text = "???"
        }
        
        if game.opponentSongID != nil && game.opponentSongDetails.isEmpty != true {
            
            opponentVideo.loadWithVideoId(game.opponentSongID)
            opponentVideoName.text = game.opponentSongDetails[0] as String!
            opponentVideoChannel.text = game.opponentSongDetails[1] as String!
            opponentVideoViewCount.text = game.opponentSongDetails[2] as String!
            
        } else {
            
            opponentStackView.alignment = .Center
            print("Opponent hasn't picked a video yet")
            
        }
    }
    
    func setCurrentUser() {
        
        currentUserProfilePic.profileID = game.currentUser.facebookID
        
        print(game.currentUser.facebookID)
        
        currentUserTotalScore.text = String(game.myTotalScore)
        currentUserVideo.loadWithVideoId(game.mySongID)
        
        if game.mySongDetails.isEmpty != true {
            
            currentUserVideoName.text = game.mySongDetails[0] as String!
            currentUserVideoChannel.text = game.mySongDetails[1] as String!
            currentUserVideoViewCount.text = game.mySongDetails[2] as String!
            
        } else {
            print("Opponent hasn't picked a video yet")
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
