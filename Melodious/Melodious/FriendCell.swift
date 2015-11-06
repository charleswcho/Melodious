//
//  FriendCell.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 11/6/15.
//  Copyright © 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class FriendCell: UITableViewCell {
    
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet var friendProfilePicture: FBSDKProfilePictureView!
    
    var friend : User! {
        didSet {
            self.updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        friendProfilePicture.layer.cornerRadius = 25
        friendProfilePicture.layer.borderColor = UIColor.lightGrayColor().CGColor
        friendProfilePicture.layer.borderWidth = 1.0
        friendProfilePicture.clipsToBounds = true
    }
    
    func updateView() {
        
        friendNameLabel.text = self.friend.name
        friendProfilePicture.profileID = self.friend.facebookID
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
