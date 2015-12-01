//
//  DebugOptions.swift
//  Melodious
//
//  Created by Charles Wesley Cho on 11/30/15.
//  Copyright © 2015 Charles Wesley Cho. All rights reserved.
//

import Foundation

public func print(items: Any..., separator: String = " ", terminator: String = "\n") {
    
    #if DEBUG
        
        var idx = items.startIndex
        let endIdx = items.endIndex
        
        repeat {
            Swift.print(items[idx++], separator: separator, terminator: idx == endIdx ? terminator : separator)
        }
            while idx < endIdx
        
    #endif
}