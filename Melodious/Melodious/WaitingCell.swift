//
//  cellStyle3.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/2/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import ParseFacebookUtilsV4

class WaitingCell: UITableViewCell {

    @IBOutlet var friendProfilePic: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setGame(inputGame: Game) {
        
        var game = inputGame
        label.text = game.opponent.name
        
        var facebookID = game.opponent.facebookID as NSString
        
        // Get user profile pic
        let url = NSURL(string: "https://graph.facebook.com/\(facebookID)/picture?type=large")
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            
        // Display the image
        let image = UIImage(data: data)
        self.friendProfilePic.image = image
        }
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
