//
//  NewGame.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 9/11/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class SongsTVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var txtSearch: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var apiKey = "AIzaSyCSxpFQyMQ92xzbreKoZsRpJnTiqV-5CLQ"
    
    var videosArray: Array<Dictionary<NSObject, AnyObject>> = []
    
    var selectedVideoIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        txtSearch.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableView method implementation
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return videosArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SongsCell", forIndexPath: indexPath) as! SongsCell
        
        let videoDetails = videosArray[indexPath.row]

        cell.videoDetails = videoDetails
        
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        selectedVideoIndex = indexPath.row
        performSegueWithIdentifier("idSeguePlayer", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "idSeguePlayer" {
            let submitSong = segue.destinationViewController as! SubmitSongVC
            submitSong.videoID = videosArray[selectedVideoIndex]["videoID"] as! String
            submitSong.videoDetails = videosArray[selectedVideoIndex]
        }
    }

    // MARK: UISearchBarDelegate method implementation
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        
        searchBar.resignFirstResponder()
        tableView.reloadData()
        
        return true
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        // Form the request URL string.
        var urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(searchBar.text)&type=video&maxResults=15&key=\(apiKey)"
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        // Create a NSURL object based on the above string.
        let targetURL = NSURL(string: urlString)
        
        // Get the results.
        performGetRequest(targetURL, completion: { (data, HTTPStatusCode, error) -> Void in
            if HTTPStatusCode == 200 && error == nil {
                // Convert the JSON data to a dictionary object.
                let resultsDict = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! Dictionary<NSObject, AnyObject>
                
                // Get all search result items ("items" array).
                let items: Array<Dictionary<NSObject, AnyObject>> = resultsDict["items"] as! Array<Dictionary<NSObject, AnyObject>>
                
                // Loop through all search results and keep just the necessary data.
                for var i=0; i<items.count; ++i {
                    let snippetDict = items[i]["snippet"] as! Dictionary<NSObject, AnyObject>
                    //                    let statisticsDict = items[i]["statistics"] as! Dictionary<NSObject, AnyObject>
                    
                    // Create a new dictionary to store the video details.
                    var videoDetailsDict = Dictionary<NSObject, AnyObject>()
                    videoDetailsDict["title"] = snippetDict["title"]
                    videoDetailsDict["channelTitle"] = snippetDict["channelTitle"]
                    videoDetailsDict["thumbnail"] = ((snippetDict["thumbnails"] as! Dictionary<NSObject, AnyObject>)["default"] as! Dictionary<NSObject, AnyObject>)["url"]
                    videoDetailsDict["videoID"] = (items[i]["id"] as! Dictionary<NSObject, AnyObject>)["videoId"]
                    //                    videoDetailsDict["viewCount"] = statisticsDict["viewCount"]
                    
                    self.videosArray.append(videoDetailsDict)
                    
                    // Reload the tableview.
                    self.tableView.reloadData()
                    
                }
                
            }
            else {
                print("HTTP Status Code = \(HTTPStatusCode)")
                print("Error while loading channel videos: \(error)")
            }
            
        })
        
    }

    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        tableView.reloadData()
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
//    func getStatistics() {
//        
//        for var i=0; i<videosArray.count; ++i {
//            let videoID = videosArray[i]["videoID"] as! String
//            var videoIDs : [String] = []
//            
//            videoIDs.append(videoID)
//            let IDsAsString = videoIDs.description
//            print(IDsAsString)
//            var urlString = "https://www.googleapis.com/youtube/v3/videospart=statistics&id=\(IDsAsString)&key=\(apiKey)"
//            urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
//
//            // Create a NSURL object based on the above string.
//            let targetURL = NSURL(string: urlString)
//            
//            performGetRequest(targetURL, completion: { (data, HTTPStatusCode, error) -> Void in
//                if HTTPStatusCode == 200 && error == nil {
//                    // Convert the JSON data to a dictionary object.
//                    let resultsDict = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! Dictionary<NSObject, AnyObject>
//                    
//                    // Get all search result items ("items" array).
//                    let items: Array<Dictionary<NSObject, AnyObject>> = resultsDict["items"] as! Array<Dictionary<NSObject, AnyObject>>
//                    
//                    // Loop through all search results and keep just the necessary data.
//                    for var i=0; i<items.count; ++i {
//                        let statisticsDict = items[i]["statistics"] as! Dictionary<NSObject, AnyObject>
//                        
//                        // Create a new dictionary to store the video details.
//                        var videoDetailsDict = Dictionary<NSObject, AnyObject>()
//
//                        videoDetailsDict["viewCount"] = statisticsDict["viewCount"]
//                        
//                        self.videosArray.append(videoDetailsDict)
//                        
//                        // Reload the tableview.
//                        self.tblVideos.reloadData()
//                        
//                    }
//                    
//                }
//                else {
//                    print("HTTP Status Code = \(HTTPStatusCode)")
//                    print("Error while loading channel videos: \(error)")
//                }
//                
//            })
//
//        }
//    }
    
    
    // MARK: Custom method implementation
    
    func performGetRequest(targetURL: NSURL!, completion: (data: NSData?, HTTPStatusCode: Int, error: NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: targetURL)
        request.HTTPMethod = "GET"
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(data: data, HTTPStatusCode: (response as! NSHTTPURLResponse).statusCode, error: error)
            })
        })
        
        task.resume()
    }

}
