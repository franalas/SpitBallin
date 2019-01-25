//
//  Bullet.swift
//  Watch Extension
//
//  Created by Francisco Turdera on 1/24/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

class Bullet: DynamicCircularObject {
    
    /**
     Initializes Bullet. Represents the shot taken by Player to destroy a Ball
    */
    init() {
        
        super.init(sprite: SKNode.init(), radius: 0, position: CGPoint.zero, velocity: CGVector.zero, acceleration: CGVector.zero)
        
    }
    
    /// If the bullet hits the floor, it disappears, if it does not, nothing changes
    func hitFloor(rect: CGRect) -> Bullet? {
        
        if floorCollision(rect: rect) {
            return nil
        }
        return self
        
    }
}
