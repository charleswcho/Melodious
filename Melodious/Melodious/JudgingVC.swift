//
//  JudgingVC.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/16/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class JudgingVC: UIViewController {

    var games : [[Game]] = []
    var gamesWaitingForJudges : [Game] {
        return games[1]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Game.fetchData { (gameObjects, error) -> Void in
            if error == nil {
                self.games = gameObjects!
                
            } else {
                
                print("Error in retrieving \(error)")
                // TODO: Add Alert view to tell the user about the problem
            }
        }
                
        for game in gamesWaitingForJudges {
            if game.judges.count < 3 {
                game.judges.append(User.currentUser()!)
            } else if game.judges.count == 3 {
                print("Already enough judges for \(game)")
            } else {
                print("Error game.judges.count = \(game.judges.count)")
            }
        }
        
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
