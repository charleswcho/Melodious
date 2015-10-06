//
//  ProfileCell.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/6/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import ParseFacebookUtilsV4

class ProfileCell: UITableViewCell {

    @IBOutlet weak var currentUserNameLabel: UILabel!
    @IBOutlet weak var currentUserWLabel: UILabel!
    @IBOutlet weak var currentUserLLabel: UILabel!
    @IBOutlet weak var currentUserTLabel: UILabel!
    @IBOutlet var currentUserProfilePic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setGame(inputGame: Game) {
        
        currentUserLLabel.text = inputGame.challenger.name
        currentUserWLabel.text = inputGame.challenger.wins.stringValue
        currentUserLLabel.text = inputGame.challenger.losses.stringValue
        currentUserTLabel.text = inputGame.challenger.ties.stringValue
        
        var facebookID = inputGame.challenger.facebookID as NSString
        
        // Get user profile pic
        let url = NSURL(string: "https://graph.facebook.com/\(facebookID)/picture?type=large")
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            
            // Display the image
            let image = UIImage(data: data)
            self.currentUserProfilePic.image = image
        }
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
