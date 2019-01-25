//
//  DynamicCircularObject.swift
//  Watch Extension
//
//  Created by Francisco Turdera on 1/24/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

/// Parent dynamic object, extended onto Ball and Bullet
class DynamicCircularObject: CircularObject {
    
    var sprite: SKNode
    
    let radius: CGFloat
    
    var position: CGPoint
    
    /// Represents velocity of self in scene
    var velocity: CGVector
    
    /// Represents acceleration of self in scene
    var acceleration: CGVector
    
    /**
     Initializes a Dynamic Circular Object, this serves as parent class for Ball and Bullet
     - Parameters:
     - sprite: Represents the image associated with the object
     - radius: Represents the radius of the object relative to scene
     - position: Represents the (x,y) position of object relative to scene
     - velocity: Represents the velocity of the object relative to scene
     - acceleration: Represents the acceleration of the object relative to scene
     */
    init(sprite: SKNode, radius: CGFloat, position: CGPoint, velocity: CGVector, acceleration: CGVector) {
        
        self.sprite = sprite
        self.radius = radius
        self.position = position
        self.velocity = velocity
        self.acceleration = acceleration
        
    }
    
    /// Returns true if self is in contact with bottom of screen, false otherwise
    func floorCollision(rect: CGRect) -> Bool {
        
        if self.position.y <= rect.minY + self.radius {
            
            return true
            
        }
        return false
    }
    
    /// Updates the position and its derivatives
    func tick(time: CGFloat) {
        
        let accComponentPosX = (1/2) * self.acceleration.dx * time * time
        let accComponentPosY = (1/2) * self.acceleration.dy * time * time
        
        self.velocity.dx += self.acceleration.dx * time
        self.velocity.dy += self.acceleration.dy * time
        self.position.x += self.velocity.dx * time + accComponentPosX
        self.position.y += self.velocity.dy * time + accComponentPosY
        
    }
    
}
