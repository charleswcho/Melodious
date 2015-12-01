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

class FriendSearchTVC: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    var selectedFriendIndex: Int!
    var friendsArray = [User]()
    var filtered = [User]()
    
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFriendsList()
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.delegate = self
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        self.tableView.tableFooterView = UIView(frame:CGRectZero)

        self.tableView.reloadData()
        
    }
    
    // MARK: Search
    
    func filterFriendsForSearchText(searchText: String) {
        self.filtered = self.friendsArray.filter({( friend: User) -> Bool in
            let stringMatch = friend.name.lowercaseString.rangeOfString(searchText.lowercaseString)
            
            return (stringMatch != nil)
        })
    }
    
    // MARK: - UISearchControllerDelegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filtered.removeAll(keepCapacity: false)
        filterFriendsForSearchText(searchController.searchBar.text!)
        
        tableView.reloadData()
    }
    
    // MARK: UITableView
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.resultSearchController.active) {
            return self.filtered.count
        } else {
            return self.friendsArray.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath) as! FriendCell
        
        if (self.resultSearchController.active) {
            
            cell.friend = filtered[indexPath.row]
        } else {
            
            cell.friend = friendsArray[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedFriendIndex = indexPath.row
        performSegueWithIdentifier("showSongs", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSongs" {
            if let pickSong = segue.destinationViewController as? SongsTVC {
                if resultSearchController.active {
                    pickSong.friend = filtered[selectedFriendIndex]
                } else {
                    pickSong.friend = friendsArray[selectedFriendIndex]
                }
            }
            if (self.resultSearchController.active) {
                self.resultSearchController.active = false
            }
        }
    }
    
    
    // MARK: Get data for table
    
    func getFriendsList() {
        
        User.currentUser()?.getUsersFriends({ (friends: [PFObject]?, error: NSError?) -> Void in         // Get List Of Friends
            
            if error == nil {
                
                self.friendsArray = friends as! [User]
                
                self.tableView.reloadData()
                
            } else {
                
                print("Error \(error)")
            }
            
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
