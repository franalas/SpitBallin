//
//  LevelNumber.swift
//  Watch Extension
//
//  Created by Liam Stevenson on 1/25/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

/// Represents the levels of the game
typealias Level = [Ball]
enum LevelNumber: Int {
    
    /// Level one
    case one = 1
    
    /// Level two
    case two
    
    /// Level three
    case three
    
    /// Level four
    case four
    
    /// Level five
    case five
    
    /// Level six
    case six
    
    /// The next level after the current one
    var nextLevel: LevelNumber {
        if let nextLevel = LevelNumber(rawValue: self.rawValue + 1) { return nextLevel }
        else { return .one }
    }
    
    /// Creates level for each case
    func makeLevel() -> Level {
        
        switch self {
            
        case .one:
             return [Ball(ballSize: .two, positionX: 0.5)]
        case .two:
            return [Ball(ballSize: .three, positionX: 0.5)]
        case .three:
            return [Ball(ballSize: .three, positionX: 0.3, right: false),
                    Ball(ballSize: .two, positionX: 0.7)]
        case .four:
            return [Ball(ballSize: .two, positionX: 0.2),
                    Ball(ballSize: .two, positionX: 0.5),
                    Ball(ballSize: .three, positionX: 0.7)]
        case .five:
            return [Ball(ballSize: .four, positionX: 0.5)]
        case .six:
            return [Ball(ballSize: .four, positionX: 0.2),
                    Ball(ballSize: .two, positionX: 0.8, right: false)]
        }
        
    }
    
}
