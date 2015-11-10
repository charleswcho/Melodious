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
    
    var videoDetails : NSDictionary!
    
    func updateView() {
        
        songNameLabel.text = videoDetails["title"] as? String
        channelNameLabel.text = videoDetails["channelTitle"] as? String
        numberOfViewsLabel.text = convertToFormattedViewCount()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queryForGames = PFQuery(className: "Game")
        queryForGames.whereKey("gameState", equalTo: 0)
        queryForGames.includeKey("player1")
        queryForGames.includeKey("player2")
        
        queryForGames.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
            
            if(error == nil){
                
                if let gameObjects = objects as? [Game] {     // Safe unpacking of array
                    
                    for game in gameObjects {
                        
                    }
                }
            }
        })
        
        self.updateView()
        playerView.loadWithVideoId(videoID)

    }
    
    @IBAction func submitSong(sender: UIButton) {
        
        let newGame = Game()
        
        if (game?.player1 == nil && game?.player2 == nil) {
            newGame.gameState = 0
            newGame.player1 = User.currentUser()
            
            if friend == nil {
            
                
            }
            
            
            newGame.player2 = friend

            newGame.player1Scores = []
            newGame.player2Scores = []
            
            newGame.player1SongID = videoID
            
            newGame.player1SongDetails = []
            newGame.player2SongDetails = []

            newGame.judges = []
            
            User.currentUser()?.points = (User.currentUser()?.points.integerValue)! - 3
            User.currentUser()?.saveEventually()
            
            newGame.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                
                if error == nil {
                    
                    newGame.player1SongDetails.append(self.videoDetails["title"] as! String)
                    newGame.player1SongDetails.append(self.videoDetails["channelTitle"] as! String)
                    newGame.player1SongDetails.append(self.convertToFormattedViewCount())
                    newGame.saveEventually()
                    NSNotificationCenter.defaultCenter().postNotificationName(homeTableNeedsReloadingNotification, object: self)
                    print("Did save player 1 data? \(success)")
                } else {
                    print("Error \(error)")
                }
            }
            
        } else if game.player1 != nil {
            
            game.gameState = 1
            game.player2SongID = videoID
            
            game.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                
                if error == nil {
                    
                    self.game.player2SongDetails.append(self.videoDetails["title"] as! String)
                    self.game.player2SongDetails.append(self.videoDetails["channelTitle"] as! String)
                    self.game.player2SongDetails.append(self.convertToFormattedViewCount())
                    self.game.saveEventually()
                    NSNotificationCenter.defaultCenter().postNotificationName(homeTableNeedsReloadingNotification, object: self)
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
    
    // Function to format viewCount
    
    func convertToFormattedViewCount() -> String {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        
        if let unformatedString = self.videoDetails["viewCount"] as? String {
            let intFromString = Int(unformatedString)
            let formatedString = numberFormatter.stringFromNumber(NSNumber(integer: intFromString!))
            numberOfViewsLabel.text = formatedString
            return formatedString!
            
        } else {
            
            print("viewCount not set yet")
            return ""
        }
    }
    
    
    func getRandomGamesThatNeedOpponent() {
  

        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
