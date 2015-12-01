//
//  ProfileTVC.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/6/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit
import Parse

class ProfileTVC: UITableViewController {

    var games : [[Game]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        User.currentUser()?.fetchIfNeededInBackgroundWithBlock({ (user: PFObject?, error: NSError?) -> Void in
            if (error != nil) {
                print("Error: \(error)")
            }
        })
        
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


    // MARK: - Table view data source
    
    // Section Delegate methods
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 30
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let homeHeaderCell = tableView.dequeueReusableCellWithIdentifier("HomeHeaderCell") as! HomeHeaderCell
        
        homeHeaderCell.trashButton.hidden = true

        if section == 1 {
            
            homeHeaderCell.section = 5
        }
            
            return homeHeaderCell

    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            
            return 1
        } else if games.count > 0 {
            
            return games[3].count
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! ProfileCell
                        
            return cell
            
        } else if indexPath.section == 1 && games.count > 0 {
            //grab array by section title
            let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath) as! GameCell
            
            cell.game = (games[3][indexPath.row])
            
            if cell.game.winner == User.currentUser() {
                
                cell.backgroundColor = Colors().greenColor
                cell.winnerLoserLabel.text = "Win"
                cell.myScoreLabel.textColor = UIColor.whiteColor()
                
            } else if cell.game.loser == User.currentUser() {
                
                cell.backgroundColor = Colors().redColor
                cell.winnerLoserLabel.text = "Loss"
                cell.opponentScoreLabel.textColor = UIColor.whiteColor()

            } else if cell.game.winner == nil {
                
                cell.backgroundColor = UIColor.lightGrayColor()
                cell.winnerLoserLabel.text = "Tie"
                print("It was a tie or game.winner is nil in error")
            }
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath) as! GameCell
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        } else if indexPath.section == 1 {
            return 100
        } else {
            return 0
        }
    }
    
    var selectedIndex : Int!
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedIndex = indexPath.row
        performSegueWithIdentifier("showGameDetail", sender: self)
        print(indexPath.section)
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showGameDetail" {
            if let gameDetail = segue.destinationViewController as? GameDetailVC {
                gameDetail.game = games[3][selectedIndex]
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
