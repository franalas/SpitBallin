//
//  Level.swift
//  Watch Extension
//
//  Created by Liam Stevenson on 1/25/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation

enum Level: Int {
    
    /// Level one
    case one = 1
    
    /// Level two
    case two
    
    /// Level three
    case three
    
    /// Level four
    case four
    
    /// The next level after the current one
    var nextLevel: Level {
        if let nextLevel = Level(rawValue: self.rawValue + 1) { return nextLevel }
        else { return .one }
    }
    
}
