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
             return [Ball(ballSize: .two, position: CGPoint(x: 0.5, y: BallSize.two.bounceHeight))]
        case .two:
            return [Ball(ballSize: .three, position: CGPoint(x: 0.5, y: BallSize.three.bounceHeight))]
        case .three:
            return [Ball(ballSize: .three, position: CGPoint(x: 0.3, y: BallSize.three.bounceHeight),
                         right: false),
                    Ball(ballSize: .two, position: CGPoint(x: 0.7, y: BallSize.two.bounceHeight))]
        case .four:
            return [Ball(ballSize: .two, position: CGPoint(x: 0.2, y: BallSize.two.bounceHeight)),
                    Ball(ballSize: .two, position: CGPoint(x: 0.5, y: BallSize.two.bounceHeight)),
                    Ball(ballSize: .three, position: CGPoint(x: 0.7, y: BallSize.three.bounceHeight))]
        case .five:
            return [Ball(ballSize: .five, position: CGPoint(x: 0.5, y: BallSize.five.bounceHeight))]
        case .six:
            return [Ball(ballSize: .five, position: CGPoint(x: 0.2, y: BallSize.five.bounceHeight)),
                    Ball(ballSize: .three, position: CGPoint(x: 0.8, y: BallSize.three.bounceHeight),
                         right: false)]
        }
        
    }
    
}
