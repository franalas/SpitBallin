//
//  Ball.swift
//  Watch Extension
//
//  Created by Francisco Turdera on 1/23/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

class Ball: SKShapeNode {
    
    /// Value added to y-velocity when ball is split in 2
    private let YSPLIT = 0.1
    
    /// Represents size of self
    private var ballSize: BallSize?
    
    
    /**
     Initializes Ball with a certain BallSize and color which will be kept constant
     as well as a position and velocity in the scene, which will be variables imported from SKShapeNode
     - Parameters:
        - ballSize: determines size of self
        - color: determines color of self
        - position: determines where in the scene self begins
        - velocity: determines initial velocity of self in scene
     */
    convenience init(ballSize: BallSize, color: UIColor, position: CGPoint, velocity: CGVector) {
       
        self.init(circleOfRadius: ballSize.radius)
        self.ballSize = ballSize
        self.fillColor = color
        self.strokeColor = .clear
        self.position = position
//        self.physicsBody = SKPhysicsBody(circleOfRadius: ballSize.radius)
//        self.physicsBody!.velocity = velocity
        
    }
    
    override private init() {
        
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Changes velocity when self hits a Border of type wall
    func bounceOffWall() {
        
        if self.physicsBody?.velocity.dx != nil {
            self.physicsBody!.velocity.dx = -1 * self.physicsBody!.velocity.dx
        }
        
    }
    
    func bounceOffFloor() {
        
        
        
    }
    
    /**
     Splits a ball into 2 smaller balls when called
     */
    func split() -> (Ball, Ball)? {
        
//        if let color = self.color, let ballSize = self.ballSize, case let physicsBody.velocity = self.physicsBody?.velocity {
//
//            var ball1 = Ball.init(ballSize: self.ballSize.nextBall, color: self.color, position: self.position, velocity: CGVector(dx: -1 * self.physicsBody.velocity.dx, dy: self.physicsBody.velocity.dy + CGFloat(YSPLIT)))
//
//        }
        return(self, self)
    }
    
}
