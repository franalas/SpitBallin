//
//  Ball.swift
//  Watch Extension
//
//  Created by Francisco Turdera on 1/24/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

/// Represents a Ball, purpose is to bounce around screen and interact with Player and Bullet
class Ball: DynamicCircularObject {
    
    /// Represents different characteristics of the Ball: size, speed it bounces off floor, and what ball comes next
    let ballSize: BallSize?
    
    /// Represent the color of the Ball
    let color: UIColor
    
    /**
     Initializes a Ball, child of DynamicCircularObject. Represents the bouncing balls in game.
     - Parameters:
        - ballSize: Represents all characteristics of the ball
        - color: Represents color of the Ball
        - radius: Represents the radius of the object relative to scene
        - position: Represents the (x,y) position of object relative to scene
        - velocity: Represents the velocity of the object relative to scene
        - acceleration: Represents the acceleration of the object relative to scene
     */
    init(ballSize: BallSize, color: UIColor, position: CGPoint = CGPoint.zero, velocity: CGVector = CGVector.zero,
         acceleration: CGVector = CGVector.zero) {
        
        self.ballSize = ballSize
        self.color = color
        let sprite = SKShapeNode(circleOfRadius: ballSize.radius)
        sprite.fillColor = color
        sprite.position = position
        
        super.init(sprite: sprite, radius: ballSize.radius, position: position, velocity: velocity, acceleration: acceleration)
        
    }
    
    /// Returns true if the ball is making contact with either side (left or right) of the screen, false otherwise
    func wallCollision(rect: CGRect) -> Bool {
        if position.x <= rect.minX + self.radius || position.x >= rect.maxX - self.radius {
            return true
        }
        return false
    }
    
    /// Changes velocity.dy if Ball is in contact with floor
    func bounceFloor(rect: CGRect) {
        
        if floorCollision(rect: rect) {
            
            self.velocity.dy = ballSize!.bounceSpeed
            
        }
        
    }
    
    /// Changes velocity.dx if Ball is in contact with wall
    func bounceWall(rect: CGRect) {
        
        if wallCollision(rect: rect) {
            
            self.velocity.dx *= -1
            
        }
        
    }
    
}
