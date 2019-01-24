//
//  BallSize.swift
//  Watch Extension
//
//  Created by Liam Stevenson on 1/23/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

/// Represents the size of a ball; the raw value is the radius in the scene
enum BallSize: CGFloat {
    
    /// Does not split; disappears when shot
    case one = 0.1
    
    /// Splits into two ones
    case two = 0.15
    
    /// Splits into two twos
    case three = 0.2
    
    /// Splits into two fours
    case four = 0.25
    
    /// Splits into two fives
    case five = 0.3
    
}
