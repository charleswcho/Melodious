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

class FriendSearchTVC: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!

    var active : Bool = false
    var friendsArray:[User] = []
    var filtered:[User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFriendsList()
        getDataForTable()
        
        tableView.reloadData()

        tableView.delegate = self
        tableView.dataSource = self
        
        searchBarOutlet.delegate = self

    }

    
    // MARK: UITableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (active) {
            
            return filtered.count
            
        } else {
            
            return friendsArray.count

        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath) as! GameCell
        
        if (active) {
            let friend = filtered[indexPath.row]
            
            cell.friend = friend
            
        } else {
            let friend = friendsArray[indexPath.row]
            
            cell.friend = friend
        }

        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("showSongs", sender: self)
        
    }
    
    // MARK: UISearchBarDelegate method implementation
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        active = true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        
        searchBar.resignFirstResponder()
        active = false
        tableView.reloadData()
        
        return true
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        active = false
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        searchBar.text = ""
        active = false
        searchBar.resignFirstResponder()
        
        tableView.reloadData()
    }
    
    func getDataForTable() {
        
        for friend in friendsArray {
            
            if friend.name.lowercaseString.containsString((searchBarOutlet.text?.lowercaseString)!) {
                filtered.append(friend)
            }
        }
    }
    
    func getFriendsList() {

        User.currentUser()?.getUsersFriends({ (friends: [PFObject]?, error: NSError?) -> Void in         // Get List Of Friends
            
            if error == nil {
                
                self.friendsArray = friends as! [User]
                
            } else {
                
                print("Error \(error)")
            }
            
        })

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
