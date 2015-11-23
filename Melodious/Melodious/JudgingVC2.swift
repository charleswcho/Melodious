//
//  JudgingVC2.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 11/3/15.
//  Copyright © 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class JudgingVC2: UIViewController {
    
    @IBOutlet var player2Video: YTPlayerView!
    @IBOutlet weak var player2SongNameLabel: UILabel!
    @IBOutlet weak var player2ChannelNameLabel: UILabel!
    @IBOutlet weak var player2VideoViewCountLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControlView!
    @IBOutlet var submitButton: UIButton!
 
    var judgedGame : Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        player2Video.loadWithVideoId(judgedGame.player2SongID)
        player2SongNameLabel.text = judgedGame.player2SongDetails[0]
        player2ChannelNameLabel.text = judgedGame.player2SongDetails[1]
        player2VideoViewCountLabel.text = judgedGame.player2SongDetails[2]
        
        _ = NSTimer.scheduledTimerWithTimeInterval(30.0, target: self, selector: "submitSongEnabled", userInfo: nil, repeats: false)

        self.navigationItem.hidesBackButton = true
        
    }
    
    // Can submit song?
    
    var canSubmitSong : Bool = false
    
    func submitSongEnabled() {
        
        print("Can press submit")
        canSubmitSong = true
        
    }
    
    @IBAction func submitButtonPressed(sender: UIButton) {
        
        if canSubmitSong == false {
            
            let alertController = AlertHelper.waitForTimerAlert()
            presentViewController(alertController, animated: true, completion: { () -> Void in
                print("Alert was shown")
            })
            
        } else {
            
        // Give Judge 1 point for judging a game
            
            User.currentUser()?.points = (User.currentUser()?.points.integerValue)! + 1
            User.currentUser()?.saveEventually()
            
            // Save player 2 Score

            if judgedGame.player2Scores.isEmpty {
                judgedGame.player2Scores.append(PointsFromViewCount.calculate(judgedGame.player2SongDetails[2]))
                
            }
            
            judgedGame.player2Scores.append(ratingControl.rating * 5)
            
            judgedGame.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                
                if error == nil {
                    if (self.judgedGame.player1Scores.count == 3 && self.judgedGame.player2Scores.count == 3) {
                        
                        if self.judgedGame.winner != nil && self.judgedGame.loser != nil { // Winner and Loser were calculated
                            
                            self.judgedGame.winner?.wins = (self.judgedGame.winner?.wins.integerValue)! + 1
                            self.judgedGame.loser?.losses = (self.judgedGame.loser?.losses.integerValue)! + 1

                        } else { // Winner or loser or both are nil therefore it was a tie
                            
                            self.judgedGame.player1.ties = self.judgedGame.player1.ties.integerValue + 1
                            self.judgedGame.player2.ties = self.judgedGame.player2.ties.integerValue + 1
                        }
                        
                        self.judgedGame.gameState = 2
                        
                        self.judgedGame.saveEventually()
                        
                    } else {
                        
                        print("Need more judges to give scores")
                    }
                    
                } else {
                    
                    print("Error: \(error)")
                    
                }
            }
            
            performSegueWithIdentifier("judgedPlayer2", sender: self)
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}