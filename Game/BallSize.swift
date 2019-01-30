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
    
    /// Color of the ball
    var color: UIColor {
        
        let turquoise = UIColor(red: 64/255, green: 224/255, blue: 208/255, alpha: 1)
        
        switch self {
        case .one:
            return .magenta
        case .two:
            return .red
        case .three:
            return turquoise
        case .four:
            return .purple
        case .five:
            return .yellow
        }
    }
    
    /// The size of the next ball after a split; nil if it splits to nothing
    var nextBall: BallSize? {
        
        if self == .one { return nil }
        else { return BallSize(rawValue: self.rawValue - 1)! }
        
    }
    
    
    /// Gets the radius of the ball for the given game size
    ///
    /// - Parameter gameSize: The size of the game scene
    /// - Returns: The radius of the ball
    func getRadius(gameSize: CGSize) -> CGFloat {
        
        switch self {
        case .one:
            return 0.03 * min(gameSize.width, gameSize.height)
        case .two:
            return 0.06 * min(gameSize.width, gameSize.height)
        case .three:
            return 0.09 * min(gameSize.width, gameSize.height)
        case .four:
            return 0.12 * min(gameSize.width, gameSize.height)
        case .five:
            return 0.15 * min(gameSize.width, gameSize.height)
        }
        
    }
    
    
    /// Gets the height to which the ball bounces after colliding with the ground
    ///
    /// - Parameter gameSize: The size of the game scene
    /// - Returns: The height to which the ball bounces
    func getBounceHeight(gameSize: CGSize) -> CGFloat {
        
        switch self {
        case .one:
            return 0.3 * gameSize.height
        case .two:
            return 0.4 * gameSize.height
        case .three:
            return 0.5 * gameSize.height
        case .four:
            return 0.6 * gameSize.height
        case .five:
            return 0.7 * gameSize.height
        }
        
    }
    
}
