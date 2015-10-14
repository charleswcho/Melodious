//
//  AnswerChallenge.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/13/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import ParseFacebookUtilsV4

class AnswerChallenge: UIViewController {

    @IBOutlet var opponentProfilePic: UIImageView!
    @IBOutlet weak var opponentNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func setGame(inputGame: Game) {
        
        opponentNameLabel.text = inputGame.opponent.name
        
        var facebookID = inputGame.opponent.facebookID as NSString
        
        // Get user profile pic
        let url = NSURL(string: "https://graph.facebook.com/\(facebookID)/picture?type=large")
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            
            // Display the image
            let image = UIImage(data: data)
            self.opponentProfilePic.image = image
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
