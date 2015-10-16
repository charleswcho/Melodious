//
//  FriendSearch.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/6/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class FriendSearchTVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
//    func getFriendsList() {
//        
//        // Get List Of Friends
//        
//        var friendsRequest : FBRequest = FBRequest.requestForMyFriends()
//        friendsRequest.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
//            
//            if error == nil {
//                
//                var friendObjects = result.objectForKey("data") as NSArray
//                var friendIDs: NSMutableArray!
//                
//                for friendObject as NSDictionary in friendObjects.count {
//                    friendIDs.addObject(friendObject.o)
//                }
//                
//                var resultdict = result as NSDictionary
//                println("Result Dict: \(resultdict)")
//                var data : NSArray = resultdict.objectForKey("data") as NSArray
//                
//                for i in 0..data.count {
//                    let valueDict : NSDictionary = data[i] as NSDictionary
//                    let id = valueDict.objectForKey("id") as String
//                    println("the id value is \(id)")
//                }
//                
//                var friends = resultdict.objectForKey("data") as NSArray
//                
//                
//                println("Found \(friends.count) friends")
//                
//            } else {
//                println("Error \(error)")
//            }
//        }
//        
//    }

    

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
