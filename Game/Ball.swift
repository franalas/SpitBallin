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
    
    /// Represents initial velocity of any Ball, as a percentage of the game scene's width
    static let SPEED_MULTIPIER: CGFloat = 0.2
    
    /// Represents initial gravity of any Ball, as a percentage of the game scene's height
    static let GRAVITY_MULTIPLIER: CGFloat = -0.2
    
    /// Represents velocity added to any Ball activated by split, as a percentage of the game scene's height
    static let YSPLIT: CGFloat = 0.15
    
    /// Represents different characteristics of the Ball: size, speed it bounces off floor, and what ball comes next
    let ballSize: BallSize
    
    /// The size of the game scene
    private let gameSize: CGSize
    
    /// Represent the color of the Ball
    var color: UIColor
    
    /**
     Initializes a Ball, child of DynamicCircularObject. Represents the bouncing balls in game.
     This initialized is used when a ball is split
     - Parameters:
        - ballSize: Represents all characteristics of the ball
        - gameSize: The size of the game scene
        - color: Represents color of the Ball
        - radius: Represents the radius of the object relative to scene
        - position: Represents the (x, y) position of object relative to scene
        - right: Decides wether the Ball initially moves right, left if false
        - speed: How fast the ball moves left and right
        - gravity: The acceleration of gravity that acts on the ball
     */
    init(ballSize: BallSize, position: CGPoint, gameSize: CGSize, right: Bool = true,
         speed: CGFloat? = nil, gravity: CGFloat? = nil, color: UIColor? = nil) {
        
        self.ballSize = ballSize
        self.color = color ?? ballSize.color
        
        self.gameSize = gameSize
        
        let sprite = SKShapeNode(circleOfRadius: ballSize.getRadius(gameSize: gameSize))
        sprite.fillColor = self.color
        sprite.strokeColor = .clear
        
        sprite.position = position
        sprite.zPosition = -CGFloat(ballSize.rawValue)
        
        super.init(sprite: sprite, radius: ballSize.getRadius(gameSize: gameSize), position: position,
                   velocity: CGVector(dx: CGFloat(right ? 1 : -1) * (speed ?? (Ball.SPEED_MULTIPIER * gameSize.width)), dy: 0),
                   acceleration: CGVector(dx: 0, dy: gravity ?? (Ball.GRAVITY_MULTIPLIER * gameSize.height)))
        
    }
    
    /**
     Initializes a Ball, child of DynamicCircularObject. Used to initialize a ball at the beggining of a level
     - Parameters:
        - ballSize: Represents all characteristics of the ball
        - positionX: Represents the X-position of object relative to scene
        - right: Decides wether the Ball initially moves right, left if false
        - speed: How fast the ball moves left and right
        - gravity: The acceleration of gravity that acts on the ball
     */
    convenience init(ballSize: BallSize, positionX: CGFloat, gameSize: CGSize, right: Bool = true,
                     speed: CGFloat? = nil, gravity: CGFloat? = nil, color: UIColor? = nil) {
        
        self.init(ballSize: ballSize, position: CGPoint(x: positionX, y: ballSize.getBounceHeight(gameSize: gameSize)), gameSize: gameSize,
                  right: right, speed: speed ?? (Ball.SPEED_MULTIPIER * gameSize.width),
                  gravity: gravity ?? (Ball.GRAVITY_MULTIPLIER * gameSize.height), color: color)
        
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
            
            self.velocity.dy = sqrt(ballSize.getBounceHeight(gameSize: gameSize) * -2 * self.acceleration.dy)
            
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
     Returns 2 Balls or just removes self
     - Returns: 2 Balls
     */
    func split() -> (Ball, Ball)? {
        
        if let nextBall = ballSize.nextBall {
            let ball1 = Ball.init(ballSize: nextBall, position: self.position, gameSize: gameSize, gravity: acceleration.dy, color: self.color)
            let ball2 = Ball.init(ballSize: nextBall, position: self.position, gameSize: gameSize, gravity: acceleration.dy, color: self.color)
            ball1.velocity = CGVector(dx: -self.velocity.dx,
                                      dy: max(Ball.YSPLIT * gameSize.height, self.velocity.dy))
            ball2.velocity = CGVector(dx: self.velocity.dx,
                                      dy: max(Ball.YSPLIT * gameSize.height, self.velocity.dy))
            return (ball1, ball2)
        }
        return nil
    }
    
}
