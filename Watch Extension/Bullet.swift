//
//  Bullet.swift
//  Watch Extension
//
//  Created by Francisco Turdera on 1/23/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

class Bullet: SKSpriteNode {
    
    /// Represents the Center Point of the Bullet
    private let CENTER: CGPoint = CGPoint(x: 0.5, y: 0.5)
    
    /**
     Initializes a Bullet, used to interact solely with Ball
     - Parameters:
        - size: size of self
        - position: where self is initialized in scene
        - velocity: initial velocity of self in scene (x should be 0, y should be always the same initial)
     */
    convenience init(size: CGSize, position: CGPoint, velocity: CGVector) {
        
        self.init()
        self.size = size
//        self.physicsBody = SKPhysicsBody(bodies: <#T##[SKPhysicsBody]#>) //Figure out the kind of input this requires
        self.position = position
        self.physicsBody!.velocity = velocity
        
    }
    
    /// Removes bullet by not returning nil when called
    func remove() -> Bullet? {
        
        return nil
        
    }
    
}
