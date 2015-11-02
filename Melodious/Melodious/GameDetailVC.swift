//
//  GameDetailVC.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/16/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class GameDetailVC: UIViewController {
    
    @IBOutlet var opponentProfilePic: UIView!
    @IBOutlet weak var opponentTotalScore: UILabel!
    @IBOutlet var opponentVideo: YTPlayerView!
    @IBOutlet var opponentVideoName: UILabel!
    @IBOutlet var opponentVideoChannel: UILabel!
    @IBOutlet var opponentVideoViewCount: UILabel!
    
    @IBOutlet var currentUserProfilePic: UIView!
    @IBOutlet weak var currentUserTotalScore: UILabel!
    @IBOutlet var currentUserVideo: YTPlayerView!
    @IBOutlet var currentUserVideoName: UILabel!
    @IBOutlet var currentUserVideoChannel: UILabel!
    @IBOutlet var currentUserVideoViewCount: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
