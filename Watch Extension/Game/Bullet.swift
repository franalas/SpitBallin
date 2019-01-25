//
//  Bullet.swift
//  Watch Extension
//
//  Created by Francisco Turdera on 1/24/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

/// Represents a shot fired from the Player. Interacts with Ball
class Bullet: DynamicCircularObject {
    
    private static let SPEED = 0.5
    private static let GRAVITY = -0.1
    
    /**
     Initializes Bullet. Represents the shot taken by Player to destroy a Ball
     - Parameters:
        - radius: Represents the radius of the object relative to scene
        - position: Represents the (x,y) position of object relative to scene
        - velocity: Represents the velocity of the object relative to scene
        - acceleration: Represents the acceleration of the object relative to scene
    */
    init(position:CGPoint = CGPoint.zero) {
        
        let spitTexture = SKTexture(imageNamed: "spit")
        let sprite = SKSpriteNode(texture: spitTexture)
        let radius = spitTexture.size().height/2
        
        super.init(sprite: sprite, radius: radius, position: position, velocity: CGVector(dx: 0, dy: Bullet.SPEED), acceleration: CGVector(dx: 0, dy: Bullet.GRAVITY))
        
    }
    
    /// If the bullet hits the floor, it disappears, if it does not, nothing changes
    func hitFloor(rect: CGRect) -> Bullet? {
        
        if floorCollision(rect: rect) {
            return nil
        }
        return self
        
    }
}
