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

    let games : [[PFObject]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numbeOfRowsArray = [3, gameState2Array.count, gameState3Array.count, gameState4Array.count]
//        var numbeOfRowsArray = [3, 1, 1, 1]

        return numbeOfRowsArray[section]
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         let titleArray = ["New Game", "Challenges", "Waiting for Opponent", "Waiting for Judge"]
        
        return titleArray[section]
    }
    
    var cell: UITableViewCell!

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            var cell = tableView.dequeueReusableCellWithIdentifier("NewGameCell", forIndexPath: indexPath) as! NewGameCell
            
            let buttonTitleArray = ["Friends", "Random", "Judge"]
            // Configure cell
            cell.label.text = buttonTitleArray[indexPath.row]
            
            return cell

            
        } else {
        //grab array by section title
            
            switch indexPath.section {
                
            case 1:
                var cell = tableView.dequeueReusableCellWithIdentifier("WaitingCell", forIndexPath: indexPath) as! WaitingCell
                cell.setGame(gameState2Array[indexPath.row] as! Game)
                
                return cell
                
            case 2:
                var cell = tableView.dequeueReusableCellWithIdentifier("WaitingCell", forIndexPath: indexPath) as! WaitingCell
                cell.setGame(gameState3Array[indexPath.row] as! Game)
                
                return cell
                
            case 3:
                var cell = tableView.dequeueReusableCellWithIdentifier("WaitingCell", forIndexPath: indexPath) as! WaitingCell
                cell.setGame(gameState4Array[indexPath.row] as! Game)
                
                return cell
                
            default:
                println("No more arrays")
            }
        }

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
