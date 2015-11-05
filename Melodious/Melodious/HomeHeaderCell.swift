//
//  HomeHeaderCell.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/25/15.
//  Copyright © 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class HomeHeaderCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet var trashButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func trashButtonPressed(sender: AnyObject) {
        print("Button pressed")
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
