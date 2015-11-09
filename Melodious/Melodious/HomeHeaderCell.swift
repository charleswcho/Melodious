//
//  HomeHeaderCell.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 10/25/15.
//  Copyright © 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class HomeHeaderCell: UITableViewCell {
    
    var section : Int! {
        didSet {
            setTitles()
            setColors()
        }
    }

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet var trashButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.headerLabel.textColor = UIColor.whiteColor()
        
    }
    
    func setTitles() {
        // Array of titles
        let titleArray : [String] = ["New Game", "Challenges", "Waiting for Opponent", "Waiting for Judge", "Recent Games"]
        
        headerLabel.text = titleArray[section]
        
    }
    
    func setColors() {
        // Creating color for headers
        let headerRedColor = UIColor(red: 208/255, green: 2/255, blue: 27/255, alpha: 0.73)
        let headerOrangeColor = UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1.0)
        let headerGreenColor = UIColor(red: 71/255, green: 211/255, blue: 33/255, alpha: 0.85)
        let headerBlueColor = UIColor(red: 74/255, green: 222/255, blue: 226/255, alpha: 1.0)
        
        let colorArray = [UIColor.clearColor(), headerRedColor, headerOrangeColor, headerGreenColor, headerBlueColor]
        
        self.backgroundColor = colorArray[section]
        
        if section == 0 {
            headerLabel.textColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1.0)
            
        }
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
