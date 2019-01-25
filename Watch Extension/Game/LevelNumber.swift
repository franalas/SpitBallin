//
//  LevelNumber.swift
//  Watch Extension
//
//  Created by Liam Stevenson on 1/25/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

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
    
    /// The next level after the current one
    var nextLevel: LevelNumber {
        if let nextLevel = LevelNumber(rawValue: self.rawValue + 1) { return nextLevel }
        else { return .one }
    }
    
    func makeLevel() -> Level {
        
        switch self {
        case .one:
            return [Ball(ballSize: .three, color: .red, position: CGPoint(x: 0.5, y: 0.5))]
        case .two:
            return [Ball(ballSize: .five, color: .red, position: CGPoint(x: 0.5, y: 0.5))]
        case .three:
            return [Ball(ballSize: .three, color: .red, position: CGPoint(x: 0.5, y: 0.5))]
        case .four:
            return [Ball(ballSize: .four, color: .red, position: CGPoint(x: 0.5, y: 0.5))]
        case .five:
            return [Ball(ballSize: .five, color: .red, position: CGPoint(x: 0.5, y: 0.5))]
        }
        
    }
    
}
