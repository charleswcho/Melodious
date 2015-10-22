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
    var selectedFriendIndex : Int!
    var friendsArray:[User]!
    var filtered:[User]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBarOutlet.delegate = self
        
        getFriendsList()
        
        tableView.reloadData()

        
    }

    
    // MARK: UITableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (active == true) {
            
            return filtered.count
        }
        
        return friendsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath) as! GameCell
        
        if (active) {
            
            cell.friend = filtered[indexPath.row]
        } else {
            
            cell.friend = friendsArray[indexPath.row]
        }

        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedFriendIndex = indexPath.row
        performSegueWithIdentifier("showSongs", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSongs" {
            let pickSong = segue.destinationViewController as! SongsTVC
            
            if (active) {
                pickSong.friendID = filtered[selectedFriendIndex].facebookID as String

            } else {
                pickSong.friendID = friendsArray[selectedFriendIndex].facebookID as String
            }
        }
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
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = friendsArray.filter({ (User) -> Bool in
            let tmp: NSString = User.name
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        
        if(filtered.count == 0) {
            active = false
        } else {
            active = true
        }
        
        tableView.reloadData()
    }
    
    
    
    
    // MARK: Get data for table

    
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

}
