//
//  cellStyle.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/2/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class NewGameCell: UITableViewCell {

    var row : Int! {
        didSet {
            setButtonTitle()
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setButtonTitle() { // Set the title of the rows in the first section
        
        let buttonTitleArray : [String] = ["Friends", "Random", "Judge"]
        label.text = buttonTitleArray[row]
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
