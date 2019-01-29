//
//  CircularObject.swift
//  Watch Extension
//
//  Created by Liam Stevenson on 1/24/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

/**
 Represents a circular object that can collide with other `CircularObject`s
 */
protocol CircularObject {
    
    /// The sprite used to draw `self` on the screen. Should only be used to add and remove `self` from a `SKScene`.
    var sprite: SKNode { get }
    
    /// The current position of `self`
    var position: CGPoint { get }
    
    /// The radius of `self`
    var radius: CGFloat { get }
    
}

extension CircularObject {
    
    /**
     Determines if two `CircularObject`s are currently colliding with each other
     - Parameters:
        - objectA: the first `CircularObject` under consideration
        - objectB: the second `CircularObject` under consideration
     - Returns: `true` if `objectA` and `objectB` are currently colliding
    */
    static func checkCollision(_ objectA: CircularObject, _ objectB: CircularObject) -> Bool {
        
        let xDif = objectA.position.x - objectB.position.x
        let yDif = objectA.position.y - objectB.position.y
        let distance = sqrt(xDif * xDif + yDif * yDif)
        
        return distance <= objectA.radius + objectB.radius
        
    }
    
}
