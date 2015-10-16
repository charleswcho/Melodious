//
//  SubmitSong.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/14/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class SubmitSongVC: UIViewController {

    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var numberOfViewsLabel: UILabel!
    
    var videoID : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playerView.loadWithVideoId(videoID)
    }
    
    @IBAction func submitSong(sender: UIButton) {
        
        // TODO: Save the songID, set game state
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
