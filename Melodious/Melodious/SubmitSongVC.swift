//
//  SubmitSong.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/14/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit
import Parse

let homeTableNeedsReloadingNotification = "homeTableNeedsReloading"

class SubmitSongVC: UIViewController {

    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var numberOfViewsLabel: UILabel!
    
    var videoID : String!
    var friend : User!
    var game : Game! {
        didSet {
        }
    }
    
    var videoDetails : NSDictionary! {
        didSet {
        }
    }
    
    func updateView() {
        
        songNameLabel.text = videoDetails["title"] as? String
        channelNameLabel.text = videoDetails["channelTitle"] as? String
        numberOfViewsLabel.text = videoDetails["viewCount"] as? String
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playerView.loadWithVideoId(videoID)
        self.updateView()

    }
    
    @IBAction func submitSong(sender: UIButton) {
        
        let newGame = Game()
        
        if (game?.player1 == nil && game?.player2 == nil) {
            newGame.gameState = 0
            newGame.player1 = User.currentUser()
            newGame.player2 = friend

            newGame.player1Scores = [0,0,0]
            newGame.player2Scores = [0,0,0]
            
            newGame.player1SongID = videoID
            
            newGame.player1SongDetails[0] = (videoDetails["title"] as? String)!
            newGame.player1SongDetails[1] = (videoDetails["channelTitle"] as? String)!
            newGame.player1SongDetails[2] = (videoDetails["viewCount"] as? String)!

            newGame.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                
                if error == nil {
                    print("Did save player 1 data? \(success)")
                } else {
                    print("Error \(error)")
                }
            }
            
        } else if game.player1 != nil {
            
            game.gameState = 1
            game.player2SongID = videoID
            
            game.player2SongDetails[0] = (videoDetails["title"] as? String)!
            game.player2SongDetails[1] = (videoDetails["channelTitle"] as? String)!
            game.player2SongDetails[2] = (videoDetails["viewCount"] as? String)!
            
            game.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                
                if error == nil {
                    print("Did save player 2 data? \(success)")
                } else {
                    print("Error \(error)")
                }
            }
            
        }
        
        // Create notification that homeTVC needs to be reloaded
        NSNotificationCenter.defaultCenter().postNotificationName(homeTableNeedsReloadingNotification, object: self)
        
        print("Home Table needs to reload")
            
        performSegueWithIdentifier("submittedSong", sender: self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}