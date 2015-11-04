//
//  JudgingVC2.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 11/3/15.
//  Copyright © 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class JudgingVC2: UIViewController {
    
    var judgedGame : Game!
    
    @IBOutlet var player2Video: YTPlayerView!
    @IBOutlet weak var player2SongNameLabel: UILabel!
    @IBOutlet weak var player2ChannelNameLabel: UILabel!
    @IBOutlet weak var player2VideoViewCountLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControlView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        player2Video.loadWithVideoId(judgedGame.player2SongID)
        player2SongNameLabel.text = judgedGame.player2SongDetails[0]
        player2ChannelNameLabel.text = judgedGame.player2SongDetails[1]
//        player2VideoViewCountLabel.text = judgedGame.player2SongDetails[2]
        
    }
    
    @IBAction func submitButtonPressed(sender: UIButton) {
        
        // Save player 2 Score
        
        judgedGame.player2Scores.append(ratingControl.rating)
        if (judgedGame.player1Scores.count == 3 && judgedGame.player2Scores.count > 3) {
            
            judgedGame.gameState = 2
            
        } else {
            print("Need more judges to give scores")
        }
        
        judgedGame.saveEventually()
        
        performSegueWithIdentifier("judgedPlayer2", sender: self)
        
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "judgedPlayer2" {
            
            let judgingVC2 = segue.destinationViewController as! JudgingVC2
            judgingVC2.judgedGame = judgedGame
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}