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
        
        // Creating color for headers
        let headerColor = UIColor(red: 74/255, green: 145/255, blue: 226/255, alpha: 1.0)
        
        self.backgroundColor = headerColor
        self.headerLabel.textColor = UIColor.whiteColor()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
