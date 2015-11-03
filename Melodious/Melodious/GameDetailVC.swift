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
    
    var game : Game! {
        didSet {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        opponentProfilePic.profileID = game.opponent.facebookID
        opponentTotalScore.text = String(game.opponentTotalScore)
        opponentVideo.loadWithVideoId(game.player2SongID)
        opponentVideoName.text = game.opponentSongDetails[0] as String!
        opponentVideoChannel.text = game.opponentSongDetails[1] as String!
//        opponentVideoViewCount.text = game.opponentSongDetails[2] as String!

        currentUserProfilePic.profileID = game.currentUser.facebookID
        currentUserTotalScore.text = String(game.myTotalScore)
        currentUserVideo.loadWithVideoId(game.mySongID)
        currentUserVideoName.text = game.mySongDetails[0] as String!
        currentUserVideoChannel.text = game.mySongDetails[1] as String!
//        currentUserVideoViewCount.text = game.mySongDetails[2] as String!

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}