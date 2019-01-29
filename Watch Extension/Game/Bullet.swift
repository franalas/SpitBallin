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
    
    /// The default initial speed
    static let SPEED: CGFloat = 2
    
    /// The default radius
    static let RADIUS: CGFloat = 0.1
    
    /// The image file name of the sprite
    static let SPRITE_IMAGE = "spit"
    
    override var velocity: CGVector {
        didSet {
            let angle = atan(velocity.dy / velocity.dx) + CGFloat.pi / 2
            if velocity.dx >= 0 { self.sprite.zRotation = angle }
            else { self.sprite.zRotation = angle + CGFloat.pi }
        }
    }
    
    /**
     Initializes Bullet. Represents the shot taken by Player to destroy a Ball
     - Parameters:
        - position: The location of `self` in the scene
        - speed: The height of the screen
        - speed: The initial upwards velocity of `self`
    */
    init(position: CGPoint = CGPoint.zero, distanceToTop: CGFloat, speed: CGFloat = Bullet.SPEED) {
        
        let spitTexture = SKTexture(imageNamed: Bullet.SPRITE_IMAGE)
        let height = Bullet.RADIUS
        let width = height * spitTexture.size().width / spitTexture.size().height
        let sprite = SKSpriteNode(texture: spitTexture, size: CGSize(width: width, height: height))
        let radius = height / 2
        
        let gravity = -speed*speed / (2 * (distanceToTop - radius))
        super.init(sprite: sprite, radius: radius, position: position,
                   velocity: CGVector(dx: 0, dy: speed), acceleration: CGVector(dx: 0, dy: gravity))
        
    }
    
    /**
     If the bullet hits the floor, it disappears, if it does not, nothing changes
     - Parameters:
        - rect: scene where floor exists
     */
    func hitFloor(rect: CGRect) -> Bullet? {
        
        if floorCollision(rect: rect) {
            return nil
        }
        return self
        
    }
    
}
