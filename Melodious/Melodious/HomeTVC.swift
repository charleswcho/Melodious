//
//  HomeTVC.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/1/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit
import Parse

class HomeTVC: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Querying data from Parse
        
        // Query Game State first > games
        var query : PFQuery = PFQuery(className: "Game")
        query.whereKey("gameState", equalTo: 1)
        query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if(error == nil){
                if let gameObjects = objects as? [PFObject] {
                    for game in gameObjects {
                        
                        let opponent: AnyObject? = game.objectForKey("opponent")
                        
                        let name: AnyObject? = opponent?.objectForKey("name")

                        let fbID: AnyObject? = opponent?.objectForKey("facebookID")
                    }
                }
            }
                
            else{
                println("Error in retrieving \(error)")
            }
            
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        switch section {
//            
//        case 0:
//            return 0
//        case 1:
//            return 1
//        case 2:
//            return 1
//        default:
//            return 0
//        }
        
        // Return the number of rows in the section.
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){}
        return 0.0
    }

    var cell: UITableViewCell!

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
            
        case 0:
            
            var cell = tableView.dequeueReusableCellWithIdentifier("cellStyle", forIndexPath: indexPath) as! cellStyle
            
            // Configure cell
            cell.label?.text = "Friends"
            return cell
            
        case 1:
            
            var cell = tableView.dequeueReusableCellWithIdentifier("cellStyle2", forIndexPath: indexPath) as! cellStyle2
           
            // Configure cell
            cell.label?.text = "Random"
            return cell

        case 2:
            
            var cell = tableView.dequeueReusableCellWithIdentifier("cellStyle", forIndexPath: indexPath) as! cellStyle

            // Configure cell
            cell.label?.text = "Judge"
            return cell
            
        default:
            // Default cell with no text
            
            cell.textLabel?.text = ""
            
        }
        


        
        switch indexPath.section {
            
        case 0:
            var cell = tableView.dequeueReusableCellWithIdentifier("cellStyle3", forIndexPath: indexPath) as!  cellStyle3
            
            // Configure cell
            
            cell.label?.text = "" // TODO: Need to put name from opponent _User reference into here
//             cell.friendProfilePic.image = //Query facebook api for profile picture of friend with Facebook ID for "opponent"
            return cell
            
        case 1:
            var cell = tableView.dequeueReusableCellWithIdentifier("cellStyle3", forIndexPath: indexPath) as! cellStyle3
            
            // Configure cell
            cell.label?.text = "" // TODO: Need to put name from opponent _User reference into here
            //             cell.friendProfilePic.image = //Query facebook api for profile picture of friend with Facebook ID for "opponent"
            return cell
            
        case 2:
            var cell = tableView.dequeueReusableCellWithIdentifier("cellStyle3", forIndexPath: indexPath) as! cellStyle3
            
            // Configure cell
            cell.label?.text = "" // TODO: Need to put name from opponent _User reference into here
            //             cell.friendProfilePic.image = //Query facebook api for profile picture of friend with Facebook ID for "opponent"
            return cell
            
        default:
            // Default cell with no text

            cell.textLabel?.text = ""
            
        }
        

        // Configure the cell...

        return cell
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
