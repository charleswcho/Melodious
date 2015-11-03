//
//  JudgingVC2.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 11/3/15.
//  Copyright © 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class JudgingVC2: UIViewController {
    
    var judgedGame : Game!
    
    @IBOutlet var player2Video: UIView!
    @IBOutlet weak var player2SongNameLabel: UILabel!
    @IBOutlet weak var player2ChannelNameLabel: UILabel!
    @IBOutlet weak var player1VideoViewCountLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControlView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func submitButtonPressed(sender: UIButton) {
        
        
        // Save player 2 Score
        
        
        
        
        
        
        
        let judgingVC = JudgingVC()
        self.navigationController?.pushViewController(judgingVC, animated: true)
        
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