//
//  NewGame.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 9/11/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class Songs: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tblVideos: UITableView!
    
    @IBOutlet weak var viewWait: UIView!
    
    @IBOutlet weak var txtSearch: UITextField!
    
    var apiKey = "AIzaSyCSxpFQyMQ92xzbreKoZsRpJnTiqV-5CLQ"
    
    var videosArray: Array<Dictionary<NSObject, AnyObject>> = []
    
    var selectedVideoIndex: Int!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblVideos.delegate = self
        tblVideos.dataSource = self
        txtSearch.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "idSeguePlayer" {
            let playerViewController = segue.destinationViewController as! PlayerViewController
            playerViewController.videoID = videosArray[selectedVideoIndex]["videoID"] as! String
        }
    }
    

}
