//
//  FriendSearch.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/6/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import ParseFacebookUtilsV4

class FriendSearchTVC: UIViewController, UITableViewDelegate, UITableViewDataSourse, UITextFieldDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var friendsArray : Array = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friendsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath) as! GameCell
        
        let friend = friendsArray[indexPath.row]
        
        cell.friend = friend
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedVideoIndex = indexPath.row
        performSegueWithIdentifier("showSongs", sender: self)
        
    }
    
    // MARK: UITextFieldDelegate method implementation
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        
        tableView.reloadData()
        
    }
    
    
    func getFriendsList() {

        // Get List Of Friends

        var fbRequest = FBSDKGraphRequest(graphPath:"/me/friends", parameters: nil);
        fbRequest.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
            
            if error == nil {
                
                var friendObjects = result.objectForKey("data") as! NSArray
                var friendIDs : NSMutableArray!
                
                for friendObject in friendObjects {
                    friendIDs.addObject(friendObject.objectForKey("id")!)
                    
                print("Friends are : \(result)")

                    
                }
                    
                var query : PFQuery
                
                query.whereKey("facebookID", containedIn: friendIDs as [AnyObject]) // Find friends whose facebookIDs are in currentUser's friend list
                
                var friendUsers = query.findObjectsInBackgroundWithBlock({ (_: [User]?, error: NSError?) -> Void in
                    if error == nil {
                        print("currentUser friends found")
                    } else {
                        print("Error getting Users from parse \(error)")
                    }
                })
                
                
            } else {
                
                print("Error Getting Friends \(error)");
                
            }
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
