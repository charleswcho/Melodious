//
//  JudgingVC.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/16/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class JudgingVC: UIViewController {

    var gamesWaitingForJudges : [Game] = []
    var gamesNeedingJudges : [Game] = []
    var judgedGame : Game!
    
    @IBOutlet var player1Video: UIView!
    @IBOutlet weak var player1SongNameLabel: UILabel!
    @IBOutlet weak var player1ChannelNameLabel: UILabel!
    @IBOutlet weak var player1VideoViewCountLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControlView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get games from Parse
        
        Game.fetchData { (gameObjects, error) -> Void in
            if error == nil {
                if let gameObjects2DArray = gameObjects {
                    self.gamesWaitingForJudges = gameObjects2DArray[1] as [Game]
                }
            } else {
                
                print("Error in retrieving \(error)")
                // TODO: Add Alert view to tell the user about the problem
            }
        }
        
        // Decide if games need a judge
        
        for game in gamesWaitingForJudges {
            if game.judges.count < 3 {
                gamesNeedingJudges.append(game)
            } else if game.judges.count == 3 {
                print("Already enough judges for \(game)")
            } else {
                print("Error game.judges.count = \(game.judges.count)")
            }
            
            game.saveEventually()
        }
        
        // Pick first game from array and setup
        judgedGame = gamesNeedingJudges.first
    
    }

    @IBAction func submitButtonPressed(sender: UIButton) {
        
        
        // Save player 1 Score
        
        
        // Save player 2 Score
        
        
        
        
        
        
        
        let judgingVC2 = JudgingVC2()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        
        
    }


}
