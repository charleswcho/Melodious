//
//  HomeTVC.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/1/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class HomeTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        // #warning Incomplete method implementation.
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
            
            cell = tableView.dequeueReusableCellWithIdentifier("cellStyle", forIndexPath: indexPath) as! cellStyle
            
            // Configure cell
            
        case 1:
            
            cell = tableView.dequeueReusableCellWithIdentifier("cellStyle2", forIndexPath: indexPath) as! cellStyle2
           
            // Configure cell

        case 2:
            
            cell = tableView.dequeueReusableCellWithIdentifier("cellStyle", forIndexPath: indexPath) as! cellStyle

            // Configure cell
            
        default:
            // Should change to default cell?
            
            cell.textLabel?.text = ""
            
        }
        
        switch indexPath.section {
            
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("cellStyle3", forIndexPath: indexPath) as!  cellStyle3
            
            // Configure cell
            
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("cellStyle3", forIndexPath: indexPath) as! cellStyle3
            
            // Configure cell
            
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("cellStyle3", forIndexPath: indexPath) as! cellStyle3
            
            // Configure cell
            
        default:
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
