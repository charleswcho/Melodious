//
//  HomeTVC.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/1/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit
import Crashlytics
import Parse
import ParseUI
import FBSDKCoreKit
import FBSDKLoginKit
import ParseFacebookUtilsV4

class HomeTVC: UITableViewController, PFLogInViewControllerDelegate {

    var games : [[Game]] = [] // Saving results of .fetchData to local array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        User.currentUser()?.wins = 0
//        User.currentUser()?.losses = 0
//        User.currentUser()?.ties = 0
//        User.currentUser()?.points = (User.currentUser()?.points.integerValue)! + 200
//        User.currentUser()?.saveEventually()
        
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
        self.games = []
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
            
                if Reachability.isConnectedToNetwork() != true {
                    let alertController = AlertHelper.noInternetConnection()
                    
                    self.presentViewController(alertController, animated: true, completion: { () -> Void in
                        print("Alert was shown")
                    })
                }
                
                print("Error in retrieving \(error)")

            }
        }
    }

    // MARK: Parse Login
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        
        User().returnUserData()
        self.dismissViewControllerAnimated(true, completion: nil)
        
        Answers.logLoginWithMethod("Digits",
            success: true,
            customAttributes: [
                "User Name": "\(User.currentUser()?.name)",
            ])
        
        self.tableView.reloadData()
        
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
            
            return 6
            
        } else if games.count > 0 {
            
            return games[section-1].count
            
        } else {
            
            return 0
        }

    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            
            return 30
            
        } else if games.count > 0 {
            
//            print(section)
            
            if games[section-1].count > 0 {
//                print("Section: \(section)")
//                print("Row count: \(games[section-1].count)")
                return 30
            }
            
            return 0
            
        } else {
            
            return 0
        }
        
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
        
        let alertController = AlertHelper.trashButtonPressedAlert(self.games[3])
        
        presentViewController(alertController, animated: true, completion: { () -> Void in
            print("Alert was shown")
        })
    }
    
    
    // MARK: Cell Delegate methods
        
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if indexPath.row % 2 == 1 {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("SpacerCell", forIndexPath: indexPath)
                
                return cell
            } else {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("NewGameCell", forIndexPath: indexPath) as! NewGameCell
                
                cell.row = indexPath.row
                
                return cell
            }
            
        } else {
            //grab array by section title
                        
            let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath) as! GameCell

            cell.game = (games[indexPath.section - 1][indexPath.row])
            
            return cell

        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            
            if indexPath.row % 2 == 1 {
                return 20
            }
            return 50
        } else {
            return 100
        }
    }
    
    // Segue to multiple VCs
    
    var selectedIndex : Int!
    var section : Int!
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
                
        let segueArray = ["FriendGame", "RandomGame", "JudgeGame"]
        
        if indexPath.section == 0 {
            
            switch indexPath.row {
            case 0:
                if User.currentUser()?.points.integerValue >= 2 {
                    
                    performSegueWithIdentifier(segueArray[0], sender: self)
                    
                } else {
                    
                    let alertController = AlertHelper.notEnoughPointsAlert()
                    presentViewController(alertController, animated: true, completion: { () -> Void in
                        print("Alert was shown")
                    })
                }

                break
            case 2:
                
                if User.currentUser()?.points.integerValue >= 2 {
                    
                    performSegueWithIdentifier(segueArray[1], sender: self)
                    
                } else {
                    
                    let alertController = AlertHelper.notEnoughPointsAlert()
                    presentViewController(alertController, animated: true, completion: { () -> Void in
                        print("Alert was shown")
                    })
                }

                break
            case 4:
                performSegueWithIdentifier(segueArray[2], sender: self)
                break
            default:
                break
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
