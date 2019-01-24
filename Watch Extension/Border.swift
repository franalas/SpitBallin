//
//  Border.swift
//  Watch Extension
//
//  Created by Francisco Turdera on 1/23/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

/// Represents the limits of the scene, oneof: wall or floor
class Border: SKNode {
    
    /// constant to know if this is a wall or floor
    private var borderType: BorderType?
    
    /**
     Initializes Border, a limit of the scene
     - Parameters:
     - borderType: Type of border, could be a wall or a floor
     */
    convenience init(borderType: BorderType, position: CGPoint, size: CGSize) {
        
        self.init()
        self.borderType = borderType
        self.position = position
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        
    }
    
    func bounce(ball: Ball) {
        if let borderType = self.borderType {
            
            switch borderType {
            case .wall:
                ball.bounceOffWall()
            case .floor:
                ball.bounceOffFloor()
                
            }
        }
        
    }
    
}
