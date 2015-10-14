//
//  HomeTVC.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/1/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import FBSDKCoreKit
import FBSDKLoginKit
import ParseFacebookUtilsV4

class HomeTVC: UITableViewController, UITableViewDelegate, UITableViewDataSource, PFLogInViewControllerDelegate {

    // Implement PFLogin
    var logInVC: PFLogInViewController! = PFLogInViewController()
    let permissions = ["public_profile", "user_friends"]
    
    var games : [[Game]] = [] // Saving results of .fetchData to local array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (PFUser.currentUser() == nil) {
            
            self.logInVC.fields = PFLogInFields.Default
            
            // MARK: Facebook
            
            self.logInVC.facebookPermissions = permissions
            
            // TODO: Need to create a custom PFLoginViewController to customize
            
            self.logInVC.delegate = self
            
            self.presentViewController(self.logInVC, animated: true, completion: nil)
            
        } else {
            
            println("User already logged in")
        }
        
        Game.fetchData { (gameObjects, error) -> Void in
            if error == nil {
                self.games = gameObjects!
                self.tableView.reloadData()
                
            } else {
                
                println("Error in retrieving \(error)")
                // TODO: Add Alert view to tell the user about the problem
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    // MARK: Parse Login
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        if (!username.isEmpty || password.isEmpty) {
            return true
        } else {
            return false
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        println("Failed to login")
    }



    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 3
        } else if games.count > 0 {
            
            return games[section-1].count
        } else {
            return 0
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         let titleArray : [String] = ["New Game", "Challenges", "Waiting for Opponent", "Waiting for Judge", "Recent Games"]
    
        return titleArray[section]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            var cell = tableView.dequeueReusableCellWithIdentifier("NewGameCell", forIndexPath: indexPath) as! NewGameCell
            
            let buttonTitleArray : [String] = ["Friends", "Random", "Judge"]
            // Configure cell
            cell.label.text = buttonTitleArray[indexPath.row]
            
            return cell

            
        } else {
        //grab array by section title
            var cell = tableView.dequeueReusableCellWithIdentifier("WaitingCell", forIndexPath: indexPath) as! WaitingCell

            cell.setGame(games[indexPath.section - 1][indexPath.row])
                
            return cell

        }
    }
    
    // Setup the Height of the cells ?? Why doesn't setting the values in interface builder work?
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 75
        } else {
            return 100
        }
    }
    
    // Segue to multiple VCs
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("\(indexPath.row)")
        
        let segueArray = ["FriendGame", "RandomGame", "JudgeGame"]
          
        if indexPath.section == 0 {
            performSegueWithIdentifier(segueArray[indexPath.row], sender: self)

        } else if indexPath.section == 1 {

            AnswerChallenge().setGame(games[0][indexPath.row])
            
        } else if indexPath.section == 2 {
            
        } else if indexPath.section == 3 {
            
        }
//
////        , "AnswerChallenge","WaitingForOpponent", "WaitingForJudge"
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
       /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
