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
        
        acceptGameButton.addTarget(self, action: "highlightBorder", forControlEvents: .TouchDown)
        acceptGameButton.layer.cornerRadius = 5
        acceptGameButton.layer.borderWidth = 2
        acceptGameButton.layer.borderColor = UIColor(red: 71/255, green: 211/255, blue: 33/255, alpha: 0.85).CGColor

        declineGameButton.layer.cornerRadius = 5
        declineGameButton.layer.borderWidth = 2
        declineGameButton.layer.borderColor = UIColor(red: 208/255, green: 2/255, blue: 27/255, alpha: 0.73).CGColor

        
    }
    
    func highlightBorder() {
        
        acceptGameButton.layer.borderColor = UIColor.lightGrayColor().CGColor
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
