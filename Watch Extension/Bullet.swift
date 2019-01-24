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
    
//    /// Represents the Center Point of the Bullet
//    private let CENTER: CGPoint = CGPoint(x: 0.5, y: 0.5)
    
    /// Represents the image of the Bullet
    private var standardTexture: SKTexture?
    
    /**
     Initializes a Bullet, used to interact solely with Ball
     - Parameters:
        - size: size of self
        - position: where self is initialized in scene
        - velocity: initial velocity of self in scene (x should be 0, y should be always the same initial)
     */
    convenience init(size: CGSize, position: CGPoint, velocity: CGVector) {
        
        let standardTexture = SKTexture(imageNamed: "spit")
        
        self.init(texture: standardTexture)
        self.standardTexture = standardTexture
        self.size = size
        self.physicsBody = SKPhysicsBody(texture: self.standardTexture!, size: self.size)
        self.position = position
        self.physicsBody!.velocity = velocity
        
    }
    
    /// Removes bullet by returning nil when called
    func remove() -> Bullet? {
        
        return nil
        
    }
    
}
