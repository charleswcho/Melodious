//
//  ScoreCell.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/6/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class ScoreCell: UITableViewCell {

    @IBOutlet weak var opponentNameLabel: UILabel!
    @IBOutlet weak var opponentScoreLabel: UILabel!
    @IBOutlet weak var currentUserScoreLabel: UILabel!
    @IBOutlet var opponentProfilePic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setGame(inputGame: Game) {
        
        opponentNameLabel.text = inputGame.player2.name
//        opponentScoreLabel.text = inputGame.opponent.
//        currentUserScoreLabel.text = inputGame.challenger.
        
        var facebookID = inputGame.player2.facebookID as NSString
        
        // Get user profile pic
        let url = NSURL(string: "https://graph.facebook.com/\(facebookID)/picture?type=large")
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            
            // Display the image
            let image = UIImage(data: data)
            self.opponentProfilePic.image = image
        }
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
