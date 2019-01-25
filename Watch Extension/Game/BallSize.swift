//
//  BallSize.swift
//  Watch Extension
//
//  Created by Liam Stevenson on 1/23/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

/// Represents the size of a ball
enum BallSize: Int {
    
    /// Does not split; disappears when shot
    case one = 1
    
    /// Splits into two ones
    case two = 2
    
    /// Splits into two twos
    case three = 3
    
    /// Splits into two fours
    case four = 4
    
    /// Splits into two fives
    case five = 5
    
    /// The y velocity at which the ball bounces off the floor
    var bounceSpeed: CGFloat {
        
        switch self {
        case .one:
            return 0.1
        case .two:
            return 0.15
        case .three:
            return 0.2
        case .four:
            return 0.25
        case .five:
            return 0.3
        }
        
    }
    
    /// The radius of the ball
    var radius: CGFloat {
        
        switch self {
        case .one:
            return 0.1
        case .two:
            return 0.15
        case .three:
            return 0.2
        case .four:
            return 0.25
        case .five:
            return 0.3
        }
        
    }
    
    /// The size of the next ball after a split; nil if it splits to nothing
    var nextBall: BallSize? {
        
        if self == .one { return nil }
        else { return BallSize(rawValue: self.rawValue - 1)! }
        
    }
    
}
