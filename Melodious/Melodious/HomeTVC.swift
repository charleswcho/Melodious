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

class HomeTVC: UITableViewController, PFLogInViewControllerDelegate {

    
    var games : [[Game]] = [] // Saving results of .fetchData to local array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (PFUser.currentUser() == nil) {
            
            // Implement PFLogin
            
            let logInVC: PFLogInViewController! = LoginVC()

            logInVC.fields = PFLogInFields.Facebook
            
            // MARK: Facebook
            
            let permissions = ["public_profile", "user_friends"]

            logInVC.facebookPermissions = permissions
            
            logInVC.delegate = self
            
            self.presentViewController(logInVC, animated: true, completion: nil)
            
            self.tableView.reloadData()
            
        } else {
            
            print("\(User.currentUser()) already logged in")
        }
        
        fetchData()
        
        // Notifications
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTable", name: homeTableNeedsReloadingNotification, object: nil)
        
    }
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // Reload table
    
    func reloadTable() {
        
        print("Home Table received notification")
        fetchData()
        self.tableView.reloadData()
    }
    
    // Get Game data from Parse
    
    func fetchData() {
        
        Game.fetchData { (gameObjects, error) -> Void in
            if error == nil {
                self.games = gameObjects!
                self.tableView.reloadData()
                
            } else {
                
                print("Error in retrieving \(error)")
                // TODO: Add Alert view to tell the user about the problem
            }
        }
    }
    
    // Get Facebook info from current User
    
    func returnUserData() {
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil) {
                // Process error
                print("Error: \(error)")
            } else {
                
                print("fetched user: \(result)")
                
                let currentUserName = result.valueForKey("name") as! String
                let currentUserFBID = result.valueForKey("id") as! String

                User.currentUser()?.name = currentUserName
                User.currentUser()?.facebookID = currentUserFBID as String
                
                if User.currentUser()?.points == nil {
                    User.currentUser()?.points = 2

                }
                
                User.currentUser()?.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                    if success {
                        NSLog("Current User name and fbID saved")
                    } else {
                        NSLog("%@", error!)
                    }
                })
            }
        })
    }
    
    
    // MARK: Parse Login
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        returnUserData()
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        print("Failed to login")
    }


    // MARK: - Table view data source

    // Section Delegate methods

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
            
        return 30
        
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let homeHeaderCell = tableView.dequeueReusableCellWithIdentifier("HomeHeaderCell") as! HomeHeaderCell
        
        homeHeaderCell.section = section
        
        if section != 4 {
            
            homeHeaderCell.trashButton.hidden = true
            
        }
        
        if tableView.numberOfRowsInSection(section) == 0 {

            return nil
            
        } else {
            
            return homeHeaderCell
        }
    
    }
    
    @IBAction func trashButtonPressed(sender: UIButton) {
        print("Button pressed")
        
        let alertController = UIAlertController(title: "Alert", message: "Do you want to delete all recent games?", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            
        }
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
        
            for game in self.games[3] {
                game.deleteInBackgroundWithBlock({ (success, error) -> Void in
                    if error == nil {

                        print("Did delete game? \(success)")
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.fetchData()
                        })
                        
                    } else {
                        
                        print("Error: \(error)")
                        
                    }
                })
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(OKAction)
        
        presentViewController(alertController, animated: true, completion: { () -> Void in
            print("Alert was shown")
        })
        
    }
    
    
    // MARK: Cell Delegate methods
        
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("NewGameCell", forIndexPath: indexPath) as! NewGameCell
            
            cell.row = indexPath.row

            return cell
            
        } else {
        //grab array by section title
            let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath) as! GameCell

            cell.game = (games[indexPath.section - 1][indexPath.row])
            
            return cell

        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 75
        } else {
            return 100
        }
    }
    
    // Segue to multiple VCs
    
    var selectedIndex : Int!
    var section : Int!
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("\(indexPath.row)")
        
        let segueArray = ["FriendGame", "RandomGame", "JudgeGame"]
        
        if indexPath.section == 0 {
            
            if indexPath.row == 2 {
                performSegueWithIdentifier(segueArray[2], sender: self)

            } else {
                
                if User.currentUser()?.points.integerValue >= 2 {
                
                    selectedIndex = indexPath.row
                    performSegueWithIdentifier(segueArray[indexPath.row], sender: self)
                    
                } else {

                    let alertController = AlertHelper.notEnoughPointsAlert()
                    presentViewController(alertController, animated: true, completion: { () -> Void in
                        print("Alert was shown")
                    })
                }
            }

        } else if indexPath.section == 1 {
            
            selectedIndex = indexPath.row
            performSegueWithIdentifier("AnswerChallenge", sender: self)
            
        } else {
            
            section = indexPath.section
            selectedIndex = indexPath.row
            performSegueWithIdentifier("GameDetail", sender: self)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AnswerChallenge" {
            
            let answerChallenge = segue.destinationViewController as! AnswerChallengeVC
            answerChallenge.game = (games[0][selectedIndex])
            
        } else if segue.identifier == "GameDetail" {
            
            let gameDetail = segue.destinationViewController as! GameDetailVC
            gameDetail.game = (games[section-1][selectedIndex])
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
