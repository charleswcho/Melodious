//
//  youTurnCell.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 9/28/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class youTurnCell: UITableViewCell {

    @IBOutlet var friendProfilePic: UIImageView!
    @IBOutlet weak var yourTurnNameLabel: UILabel!
    @IBOutlet weak var winCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
