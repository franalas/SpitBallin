//
//  Ball.swift
//  Watch Extension
//
//  Created by Francisco Turdera on 1/23/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

///Represents a Ball, there could be many in a scene
class Ball: SKShapeNode {
    
    /// Value added to y-velocity when ball is split in 2
    private let YSPLIT = 0.1
    
    /// Represents size of self
    private var ballSize: BallSize?
    
    /// Represents the center of a circle, where it's (0,0) is
    private let CENTER: CGPoint = CGPoint(x: 0.5, y: 0.5)
    
    /**
     Initializes Ball with a certain BallSize and color which will be kept constant
     as well as a position and velocity in the scene, which will be variables imported from SKShapeNode
     - Parameters:
        - ballSize: determines size of self
        - strokeColor: determines color of self
        - position: determines where in the scene self begins
        - velocity: determines initial velocity of self in scene
     */
    convenience init(ballSize: BallSize, strokeColor: UIColor, position: CGPoint, velocity: CGVector) {
       
        self.init(circleOfRadius: ballSize.radius)
        self.ballSize = ballSize
        self.fillColor = strokeColor
        self.strokeColor = .clear
        self.position = position
        self.physicsBody = SKPhysicsBody(circleOfRadius: ballSize.radius, center: CENTER)
        self.physicsBody!.velocity = velocity
        
    }
    
    /// Changes velocity when self hits a Border of type wall
    func bounceOffWall() {
        
        if self.physicsBody?.velocity.dx != nil {
            self.physicsBody!.velocity.dx = -1 * self.physicsBody!.velocity.dx
        }
        
    }
    
    func bounceOffFloor() {
        
        if self.physicsBody?.velocity.dy != nil {
            self.physicsBody?.velocity.dy = self.ballSize!.bounceSpeed
        }
        
    }
    
    /**
     Splits a ball into 2 smaller balls when called
     */
    func split() -> (Ball, Ball)? {
        if let ballSize = self.ballSize, let velocity = self.physicsBody?.velocity {
            if let nextBall = ballSize.nextBall {
                let ball1 = Ball.init(ballSize: nextBall, strokeColor: self.strokeColor, position: position, velocity: CGVector(dx: -1 * velocity.dx, dy: velocity.dy + CGFloat(YSPLIT)))
                let ball2 = Ball.init(ballSize: nextBall, strokeColor: self.strokeColor, position: position, velocity: CGVector(dx: velocity.dx, dy: velocity.dy + CGFloat(YSPLIT)))
                return (ball1, ball2)
            }

        }
        return nil
    }
    
}
