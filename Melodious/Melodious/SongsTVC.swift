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
    
    var selectedVideoIndex : Int!
    
    var row : Int!
    
    var friend : User!
    
    var game : Game!
    
    var videoDetailsDict = Dictionary<NSObject, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        txtSearch.delegate = self
        
    }
    
    // MARK: UITableView method implementation
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return videosArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        row = indexPath.row
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SongsCell", forIndexPath: indexPath) as! SongsCell
        
        cell.videoDetails = videosArray[indexPath.row]
        
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
            submitSong.friend = self.friend
            submitSong.game = game
        }
    }

    // MARK: UISearchBarDelegate method implementation
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        videosArray = []
        tableView.reloadData()
        searchBar.resignFirstResponder()
        
        // Form the request URL string.
        var urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&fields=items(id,snippet(title,channelTitle,thumbnails))&order=viewCount&q=\(searchBar.text!)&type=video&maxResults=15&key=\(apiKey)"
        
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
                    
                    self.videoDetailsDict["title"] = snippetDict["title"]
                    self.videoDetailsDict["channelTitle"] = snippetDict["channelTitle"]
                    self.videoDetailsDict["thumbnail"] = ((snippetDict["thumbnails"] as! Dictionary<NSObject, AnyObject>)["default"] as! Dictionary<NSObject, AnyObject>)["url"]
                    self.videoDetailsDict["videoID"] = (items[i]["id"] as! Dictionary<NSObject, AnyObject>)["videoId"]
                    
                    self.videosArray.append(self.videoDetailsDict)
                    // Reload the tableview.
                    self.tableView.reloadData()
                    
                }
                
                self.getStatistics()
                
            }
            else {
                print("HTTP Status Code = \(HTTPStatusCode)")
                print("Error while loading channel videos: \(error)")
            }
            
        })
        
    }

    func getStatistics() {

        var videoIDs : [String] = []

        for var i=0; i<videosArray.count; ++i {
            let videoID = videosArray[i]["videoID"] as! String
            videoIDs.append(videoID)

        }
        
        let IDsAsString = videoIDs.joinWithSeparator(",")
        
        print(IDsAsString)
        var urlString = "https://www.googleapis.com/youtube/v3/videos?part=statistics&fields=items(statistics(viewCount))&id=\(IDsAsString)&key=\(apiKey)"
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        // Create a NSURL object based on the above string.
        let targetURL = NSURL(string: urlString)
        
        performGetRequest(targetURL, completion: { (data, HTTPStatusCode, error) -> Void in
            if HTTPStatusCode == 200 && error == nil {
                // Convert the JSON data to a dictionary object.
                let resultsDict = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! Dictionary<NSObject, AnyObject>
                
                // Get all search result items ("items" array).
                let items: Array<Dictionary<NSObject, AnyObject>> = resultsDict["items"] as! Array<Dictionary<NSObject, AnyObject>>
                
                // Loop through all search results and keep just the necessary data.
                for var i=0; i<items.count; ++i {
                    let statisticsDict = items[i]["statistics"] as! Dictionary<NSObject, AnyObject>
                    
                    self.videosArray[self.row]["viewCount"] = statisticsDict["viewCount"]
                    
                    // Reload the tableview.
                    self.tableView.reloadData()
                    
                }
                
            } else {
                print("HTTP Status Code = \(HTTPStatusCode)")
                print("Error while loading channel videos: \(error)")
            }
            
        })
    }
    
    
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

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
