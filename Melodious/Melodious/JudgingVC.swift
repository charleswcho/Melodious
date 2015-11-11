//
//  JudgingVC.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/16/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit
import Parse

class JudgingVC: UIViewController {

    var judgedGame : Game! {
        didSet {
            self.loadJudgeView()
        }
    }
    
    var games : [Game]!
    
    @IBOutlet var player1Video: YTPlayerView!
    @IBOutlet weak var player1SongNameLabel: UILabel!
    @IBOutlet weak var player1ChannelNameLabel: UILabel!
    @IBOutlet weak var player1VideoViewCountLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControlView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get games from Parse

        let queryForGames = PFQuery(className: "Game")
        queryForGames.whereKey("gameState", equalTo: 1)
        queryForGames.includeKey("player1")
        queryForGames.includeKey("player2")
        
        queryForGames.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
            
            if(error == nil){
                
                if let gameObjects = objects as? [Game] { // Safe unpacking of array
                    
                    self.games = gameObjects
                    self.checkIfGameNeedsJudge()
                }
                
            } else {
                
                print("Error in retrieving games \(error)")
                // TODO: Add Alert view to tell the user about the problem
            }
        })
    }
    
    func checkIfGameNeedsJudge() {
        
        if !games.isEmpty { // There are games that are needing to be judged
            
            for game in games {
                
                if (game.player1 != User.currentUser() && game.player2 != User.currentUser() && currentUserIsJudge(game) == false) {
                    if game.judges?.count < 3 {
                        
                        self.judgedGame = game
                        break
                        
                    } else {
                        
                        print("Error game.judges.count = \(game.judges.count)")
                        
                    }
                    
                    game.saveEventually()
                    
                } else { // The currentUser is either a player or judge in all the judged games
                    
                    self.noGamesNeedJudgesAlert()
                    
                }
            }
            
        } else { // There are no games that are needing to be judged
            
            self.noGamesNeedJudgesAlert()
            
        }
    }
    
    func currentUserIsJudge(game: Game) -> Bool {
        
        var isJudge : Bool!
        
        for judge in game.judges {
            
            if judge == User.currentUser() {
                
                isJudge = true
                
            } else {
                
                isJudge = false
            }
        }
        
        return isJudge
    }
    
    func loadJudgeView() {
        
        // Pick first game from array and setup
        
        if judgedGame != nil {
            
            player1Video.loadWithVideoId(judgedGame.player1SongID)
            player1SongNameLabel.text = judgedGame.player1SongDetails[0]
            player1ChannelNameLabel.text = judgedGame.player1SongDetails[1]
            player1VideoViewCountLabel.text = judgedGame.player1SongDetails[2]
            
        } else {

            noGamesNeedJudgesAlert()
            
        }
    }

    @IBAction func submitButtonPressed(sender: UIButton) {
        
        // Save player 1 Score
        
        judgedGame.player1Scores.append(ratingControl.rating)
        judgedGame.judges.append(User.currentUser()!)
        judgedGame.saveEventually()
        
        performSegueWithIdentifier("judgedPlayer1", sender: self)
        
    }
    
    // MARK: Alert for no games needing Judges
    
    func noGamesNeedJudgesAlert() {
        
        let alertController = UIAlertController(title: "Alert", message: "Sorry, no games to judge!", preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            self.performSegueWithIdentifier("noGamesToJudge", sender: self)
            
        }
                
        alertController.addAction(OKAction)
        
        presentViewController(alertController, animated: true, completion: { () -> Void in
            print("Alert was shown")
        })

        
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "judgedPlayer1" {
            
            let judgingVC2 = segue.destinationViewController as! JudgingVC2
            judgingVC2.judgedGame = judgedGame
        }
    }
    
//    for judge in game.judges {
//    
//    if judge != User.currentUser() {
//    
//    } else {
//    
//    self.noGamesNeedJudgesAlert()
//    
//    }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
