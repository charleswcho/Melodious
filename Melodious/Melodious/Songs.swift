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
            let submitSong = segue.destinationViewController as! SubmitSongVC
            submitSong.videoID = videosArray[selectedVideoIndex]["videoID"] as! String
        }
    }
    
    // MARK: UITableView method implementation
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return videosArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("SongsCell", forIndexPath: indexPath) as! SongsCell
        
        let videoDetails = videosArray[indexPath.row]

        cell.setCell(videoDetails)
        
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        selectedVideoIndex = indexPath.row
        performSegueWithIdentifier("idSeguePlayer", sender: self)
        
    }

    
    // MARK: UITextFieldDelegate method implementation
//    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        viewWait.hidden = false
//        
//        // Specify the search type (channel, video).
//      
//
//        // Form the request URL string.
//        var urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(textField.text)&type=video&key=\(apiKey)"
//        urlString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
//        
//        // Create a NSURL object based on the above string.
//        let targetURL = NSURL(string: urlString)
//        
//        // Get the results.
//        performGetRequest(targetURL, completion: { (data, HTTPStatusCode, error) -> Void in
//            if HTTPStatusCode == 200 && error == nil {
//                // Convert the JSON data to a dictionary object.
//                let resultsDict = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! Dictionary<NSObject, AnyObject>
//                
//                // Get all search result items ("items" array).
//                let items: Array<Dictionary<NSObject, AnyObject>> = resultsDict["items"] as! Array<Dictionary<NSObject, AnyObject>>
//                
//                // Loop through all search results and keep just the necessary data.
//                for var i=0; i<items.count; ++i {
//                    let snippetDict = items[i]["snippet"] as! Dictionary<NSObject, AnyObject>
//                    
//                    // Gather the proper data depending on whether we're searching for channels or for videos.
//                    if self.segDisplayedContent.selectedSegmentIndex == 0 {
//                        // Keep the channel ID.
//                        self.desiredChannelsArray.append(snippetDict["channelId"] as! String)
//                    }
//                    else {
//                        // Create a new dictionary to store the video details.
//                        var videoDetailsDict = Dictionary<NSObject, AnyObject>()
//                        videoDetailsDict["title"] = snippetDict["title"]
//                        videoDetailsDict["thumbnail"] = ((snippetDict["thumbnails"] as! Dictionary<NSObject, AnyObject>)["default"] as! Dictionary<NSObject, AnyObject>)["url"]
//                        videoDetailsDict["videoID"] = (items[i]["id"] as! Dictionary<NSObject, AnyObject>)["videoId"]
//                        
//                        // Append the desiredPlaylistItemDataDict dictionary to the videos array.
//                        self.videosArray.append(videoDetailsDict)
//                        
//                        // Reload the tableview.
//                        self.tblVideos.reloadData()
//                    }
//                }
//                
//                // Call the getChannelDetails(…) function to fetch the channels.
//                if self.segDisplayedContent.selectedSegmentIndex == 0 {
//                    self.getChannelDetails(true)
//                }
//                
//            }
//            else {
//                println("HTTP Status Code = \(HTTPStatusCode)")
//                println("Error while loading channel videos: \(error)")
//            }
//            
//            // Hide the activity indicator.
//            self.viewWait.hidden = true
//        })
//        
//        
//        return true
//    }
    

    
    

}
