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
            self.updateViewForGame()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func updateViewForGame() {
        
        opponentNameLabel.text = game.opponent.name
        
        // Get user profile pic
        opponentProfilePic.profileID = game.opponent.facebookID
        
    }
    
    @IBAction func acceptGame(sender: UIButton) {
        
        game.gameState = 0
        
        game.saveEventually()
        
        performSegueWithIdentifier("selectSong", sender: self)
    }
    
    @IBAction func declineGame(sender: UIButton) {
        
        game = nil
        
        game.saveEventually()
        
        performSegueWithIdentifier("declineGame", sender: self)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
