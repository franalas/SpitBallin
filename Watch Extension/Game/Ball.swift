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
    
    /// Represents initial velocity of any Ball
    private static let SPEED: CGFloat = 0.1
    
    /// Represents initial gravity of any Ball
    private static let GRAVITY: CGFloat = -0.1
    
    /// Represents velocity added to any Ball activated by split
    private static let YSPLIT: CGFloat = 0.1
    
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
        - speed: How fast the ball moves left and right
        - gravity: The acceleration of gravity that acts on the ball
     */
    init(ballSize: BallSize, color: UIColor, position: CGPoint = CGPoint.zero,
         speed: CGFloat = Ball.SPEED, gravity: CGFloat = Ball.GRAVITY) {
        
        self.ballSize = ballSize
        self.color = color
        let sprite = SKShapeNode(circleOfRadius: ballSize.radius)
        sprite.fillColor = color
        sprite.strokeColor = .clear
        sprite.position = position
        
        super.init(sprite: sprite, radius: ballSize.radius, position: position,
                   velocity: CGVector(dx: speed, dy: 0), acceleration: CGVector(dx: 0, dy: gravity))
        
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
    
    /// Removes self and adds 2 Balls to scene or just removes self
    func split() -> (Ball, Ball)? {
        if let ballSize = self.ballSize {
            if let nextBall = ballSize.nextBall {
                let ball1 = Ball.init(ballSize: nextBall, color: self.color, position: position, speed:(-1 * self.velocity.dy + Ball.YSPLIT), gravity: acceleration.dy)
                let ball2 = Ball.init(ballSize: nextBall, color: self.color, position: position, gravity: acceleration.dy)
                ball1.velocity = CGVector(dx: self.velocity.dx, dy: -1 * self.velocity.dy + Ball.YSPLIT)
                ball2.velocity = CGVector(dx: self.velocity.dx, dy: self.velocity.dy + Ball.YSPLIT)
                return (ball1, ball2)
            }
            
        }
        return nil
    }
    
}
