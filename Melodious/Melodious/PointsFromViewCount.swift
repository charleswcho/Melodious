//
//  PointsFromViewCount.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 11/16/15.
//  Copyright © 2015 Charles Wesley Cho. All rights reserved.
//

import UIKit

class PointsFromViewCount: NSObject {
    
    static func calculate(viewCountAsString: String) -> Int {
        
        let stringWithoutCommas = viewCountAsString.stringByReplacingOccurrencesOfString(",", withString: "")
        
        let v = Int(stringWithoutCommas)!
        var points : Int!
        
        if v >= 1000000000 {
            points = 0
            
        } else if v >= 500000000 {
            points = 5

        } else if v >= 250000000 {
            points = 10

        } else if v >= 100000000 {
            points = 15

        } else if v >=  50000000 {
            points = 20

        } else if v >=  10000000 {
            points = 25

        } else if v >=   5000000 {
            points = 30

        } else if v >=   1000000 {
            points = 35

        } else if v >=    500000 {
            points = 40

        } else if v >=    250000 {
            points = 45

        } else if v >=         0 {
            points = 50
            
        }
        
        return points
    }

}
