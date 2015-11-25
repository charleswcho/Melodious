//
//  Colors.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 11/24/15.
//  Copyright © 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class Colors: NSObject {

    let redColor = UIColor(red: 208/255, green: 2/255, blue: 27/255, alpha: 0.73)
    let orangeColor = UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1.0)
    let greenColor = UIColor(red: 72/255, green: 211/255, blue: 33/255, alpha: 1.0)
    let lightBlueColor = UIColor(red: 74/255, green: 222/255, blue: 226/255, alpha: 1.0)
    let blueColor = UIColor(red: 74/255, green: 145/255, blue: 226/255, alpha: 1.0)

    let selectedGreen = UIColor(red: 28/255, green: 83/255, blue: 12/255, alpha: 1.0)
    let selectedRed = UIColor(red: 79/255, green: 0/255, blue: 10/255, alpha: 1.0)


    func setColors(section: Int) -> UIColor {
        // Creating color for headers

        let colorArray = [UIColor.clearColor(), redColor, orangeColor, greenColor, lightBlueColor, blueColor]

        return colorArray[section]
    }
    
    
}
