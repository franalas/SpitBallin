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
    static let SPEEDMULTIPLIER: CGFloat = 2
    
    /// The default radius
    static let RADIUSMULTIPLIER: CGFloat = 0.05
    
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
    init(gameSize: CGSize, position: CGPoint, distanceToTop: CGFloat, speed: CGFloat = Bullet.SPEEDMULTIPLIER) {
        
        let spitTexture = SKTexture(imageNamed: Bullet.SPRITE_IMAGE)
        let height = Bullet.RADIUSMULTIPLIER * 2 * gameSize.height
        let width = height * spitTexture.size().width / spitTexture.size().height
        let sprite = SKSpriteNode(texture: spitTexture, size: CGSize(width: width, height: height))
        let radius = Bullet.RADIUSMULTIPLIER * min(gameSize.width, gameSize.height)
        
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
