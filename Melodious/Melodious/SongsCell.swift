//
//  SongsCell.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/14/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class SongsCell: UITableViewCell {

    @IBOutlet var thumbnailPic: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var numberOfViewsLabel: UILabel!
    
    var videoDetails : NSDictionary! {
        didSet {
            self.updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateView() {
        
        thumbnailPic.image = UIImage(data: NSData(contentsOfURL: NSURL(string: (videoDetails["thumbnail"] as? String)!)!)!)
        songNameLabel.text = videoDetails["title"] as? String
        channelNameLabel.text = videoDetails["channelTitle"] as? String
        
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        
        if let unformatedString = videoDetails["viewCount"] as? String {
            let intFromString = Int(unformatedString)
            let formatedString = numberFormatter.stringFromNumber(NSNumber(integer: intFromString!))
            numberOfViewsLabel.text = formatedString
            
        } else {
            
            print("viewCount not set yet")
        }
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
