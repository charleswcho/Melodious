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
    
    var game : Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        opponentNameLabel.text = game.opponent?.name
        
        // Get user profile pic
        opponentProfilePic.profileID = game.opponent?.facebookID
        
        // Add corners and border
        opponentProfilePic.layer.cornerRadius = opponentProfilePic.frame.size.width / 2
        opponentProfilePic.layer.borderColor = UIColor.lightGrayColor().CGColor
        opponentProfilePic.layer.borderWidth = 1.0
        opponentProfilePic.clipsToBounds = true
        
        setupButtons()
    }
    
    @IBAction func acceptGame(sender: UIButton) {
        
        performSegueWithIdentifier("selectSong", sender: self)
    }
    
    @IBAction func declineGame(sender: UIButton) {
        
        game.deleteEventually()
        
        // Create notification that homeTVC needs to be reloaded
        print("Home Table needs to reload")

        NSNotificationCenter.defaultCenter().postNotificationName(homeTableNeedsReloadingNotification, object: self)
                
        performSegueWithIdentifier("declineGame", sender: self)

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectSong" {
            let songs = segue.destinationViewController as! SongsTVC
            songs.game = self.game
        }
    }
    
    // Setup buttons
    
    func setupButtons() {
        
        acceptGameButton.addTarget(self, action: "highlightAcceptBorder", forControlEvents: .TouchDown)
        acceptGameButton.addTarget(self, action: "unhighlightAcceptBorder", forControlEvents: .TouchUpInside)
        acceptGameButton.layer.borderColor = Colors().greenColor.CGColor
        
        declineGameButton.addTarget(self, action: "highlightDeclineBorder", forControlEvents: .TouchDown)
        declineGameButton.addTarget(self, action: "unhighlightDeclineBorder", forControlEvents: .TouchUpInside)
        declineGameButton.layer.borderColor = Colors().redColor.CGColor

        
    }
    
    func highlightAcceptBorder() { // Selected State for Accept Button
        
        acceptGameButton.layer.borderColor = Colors().selectedGreen.CGColor
    }
    
    func unhighlightAcceptBorder() {
        acceptGameButton.layer.borderColor = Colors().greenColor.CGColor
    }
    
    func highlightDeclineBorder() { // Selected State for Decline Button
        
        declineGameButton.layer.borderColor = Colors().selectedRed.CGColor
    }
    
    func unhighlightDeclineBorder() {
        declineGameButton.layer.borderColor = Colors().redColor.CGColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
