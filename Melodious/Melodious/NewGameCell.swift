//
//  cellStyle.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/2/15.
//  Copyright (c) 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class NewGameCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    var inset : CGFloat = 16.0
    var row : Int! {
        didSet {
            setButtonTitle()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.lightGrayColor().CGColor
        
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.x += self.inset
            frame.size.width -= 2 * self.inset
            super.frame = frame
        }
    }
    
    func setButtonTitle() { // Set the title of the rows in the first section
        
        let buttonTitleArray : [String] = ["Friends","", "Random","", "Judge",""]
        label.text = buttonTitleArray[row]
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
