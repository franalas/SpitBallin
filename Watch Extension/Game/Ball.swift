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
    private static let SPEED: CGFloat = 0.2
    
    /// Represents initial gravity of any Ball
    private static let GRAVITY: CGFloat = -0.2
    
    /// Represents velocity added to any Ball activated by split
    private static let YSPLIT: CGFloat = 0.15
    
    /// Represents different characteristics of the Ball: size, speed it bounces off floor, and what ball comes next
    let ballSize: BallSize
    
    /// Represent the color of the Ball
    var color: UIColor
    
    /**
     Initializes a Ball, child of DynamicCircularObject. Represents the bouncing balls in game.
     - Parameters:
     - ballSize: Represents all characteristics of the ball
     - color: Represents color of the Ball
     - radius: Represents the radius of the object relative to scene
     - positionX: Represents the X-position of object relative to scene
     - right: Decides wether the Ball initially moves right, left if false
     - speed: How fast the ball moves left and right
     - gravity: The acceleration of gravity that acts on the ball
     */
    init(ballSize: BallSize, position: CGPoint, right: Bool = true,
         speed: CGFloat = Ball.SPEED, gravity: CGFloat = Ball.GRAVITY, color: UIColor? = nil) {
        
        self.ballSize = ballSize
        self.color = color ?? ballSize.color
        
        let sprite = SKShapeNode(circleOfRadius: ballSize.radius)
        sprite.fillColor = self.color
        sprite.strokeColor = .clear
        
        sprite.position = position
        sprite.zPosition = -CGFloat(ballSize.rawValue)
        
        if right {
            super.init(sprite: sprite, radius: ballSize.radius, position: position,
                       velocity: CGVector(dx: speed, dy: 0), acceleration: CGVector(dx: 0, dy: gravity))
        } else {
            super.init(sprite: sprite, radius: ballSize.radius, position: position,
                       velocity: CGVector(dx: -speed, dy: 0), acceleration: CGVector(dx: 0, dy: gravity))
        }
        
    }
    
    convenience init(ballSize: BallSize, positionX: CGFloat = 0.5, right: Bool = true, speed: CGFloat = Ball.SPEED, gravity: CGFloat = Ball.GRAVITY, color: UIColor? = nil) {
        
        self.init(ballSize: ballSize, position: CGPoint(x: positionX, y: ballSize.bounceHeight), right: right, speed: speed, gravity: gravity, color: color)
        
    }
    
    /**
     Is the ball making contact with the wall?
     - Parameters:
     - rect: scene where wall exists
     - Returns: true if the ball is making contact with either side (left or right) of the screen, false otherwise
     */
    func wallCollision(rect: CGRect) -> Bool {
        if position.x <= rect.minX + self.radius || position.x >= rect.maxX - self.radius {
            return true
        }
        return false
    }
    
    /**
     Changes velocity.dy if Ball is in contact with floor
     - Parameters:
     - rect: scene where floor exists
     */
    func bounceFloor(rect: CGRect) {
        
        if floorCollision(rect: rect) {
            
            self.velocity.dy = sqrt(ballSize.bounceHeight * -2 * self.acceleration.dy)
            
        }
        
    }
    
    /**
     Changes velocity.dx if Ball is in contact with wall
     - Parameters:
     - rect: scene where wall exists
     */
    func bounceWall(rect: CGRect) {
        
        if wallCollision(rect: rect) {
            let positionHolder = position.x > rect.midX
            if positionHolder {
                self.velocity.dx = -abs(velocity.dx)
            } else{
                self.velocity.dx = abs(velocity.dx)
            }
            
        }
        
    }
    
    /**
     Removes self and returns 2 Balls or just removes self
     - Returns: 2 Balls
     */
    func split() -> (Ball, Ball)? {
        
        if let nextBall = ballSize.nextBall {
            let ball1 = Ball.init(ballSize: nextBall, position: self.position, gravity: acceleration.dy, color: self.color)
            let ball2 = Ball.init(ballSize: nextBall, position: self.position, gravity: acceleration.dy, color: self.color)
            ball1.velocity = CGVector(dx: -self.velocity.dx,
                                      dy: max(Ball.YSPLIT, self.velocity.dy + Ball.YSPLIT))
            ball2.velocity = CGVector(dx: self.velocity.dx,
                                      dy: max(Ball.YSPLIT, self.velocity.dy + Ball.YSPLIT))
            return (ball1, ball2)
        }
        return nil
    }
    
}
