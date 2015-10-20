//
//  AnswerChallenge.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/13/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import ParseFacebookUtilsV4

class AnswerChallengeVC: UIViewController {

    @IBOutlet var opponentProfilePic: FBSDKProfilePictureView!
    @IBOutlet weak var opponentNameLabel: UILabel!
    
    @IBOutlet var acceptGameButton: UIButton!
    @IBOutlet var declineGameButton: UIButton!
    
    
    var game : Game! {
        didSet {
        }
    }

    func updateViewForGame() {
        
        opponentNameLabel.text = game.opponent?.name
        
        // Get user profile pic
        opponentProfilePic.profileID = game.opponent?.facebookID
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateViewForGame()
        
    }
    
    @IBAction func acceptGame(sender: UIButton) {
        
        game.gameState = 0
        
        game.saveEventually()
        
        performSegueWithIdentifier("selectSong", sender: self)
    }
    
    @IBAction func declineGame(sender: UIButton) {
        
        game.deleteEventually()
        
        performSegueWithIdentifier("declineGame", sender: self)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
