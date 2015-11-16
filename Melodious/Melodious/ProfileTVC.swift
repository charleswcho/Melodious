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

        Game.fetchData { (gameObjects, error) -> Void in
            if error == nil {
                self.games = gameObjects!
                self.tableView.reloadData()
                
            } else {
                
                print("Error in retrieving \(error)")
                // TODO: Add Alert view to tell the user about the problem
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

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
        
        if tableView.numberOfRowsInSection(section) == 0 {
            
            return nil
            
        } else {
            
            return homeHeaderCell
        }
        
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
                
                cell.backgroundColor = UIColor(red: 72/255, green: 211/255, blue: 33/255, alpha: 1.0)
                
            } else if cell.game.winner != User.currentUser() {
                
                cell.backgroundColor = UIColor(red: 208/255, green: 2/255, blue: 27/255, alpha: 1.0)

            } else {
                
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
