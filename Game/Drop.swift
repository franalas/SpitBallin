//
//  Drop.swift
//  SpitBallin
//
//  Created by Liam Stevenson on 1/30/19.
//  Copyright © 2019 Stevera. All rights reserved.
//

import Foundation
import SpriteKit

class Drop: DynamicCircularObject {
    
    /// Represents default initial gravity of a drop, as a percentage of the game scene's height
    static let GRAVITY_MULTIPLIER: CGFloat = -0.2
    
    /// Represents the default size of a drop, as a percentage of the game scene's minimum dimension
    static let SIZE_MULTIPLIER: CGFloat = 0.08
    
    let dropType: DropType
    
    convenience init(dropType: DropType, position: CGPoint, gameSize: CGSize) {
        
        self.init(dropType: dropType, position: position, gravity: Drop.GRAVITY_MULTIPLIER * gameSize.height,
                  height: Drop.SIZE_MULTIPLIER * min(gameSize.width, gameSize.height))
        
    }
    
    init(dropType: DropType, position: CGPoint, gravity: CGFloat, height: CGFloat) {
        
        self.dropType = dropType
        
        let texture = SKTexture(imageNamed: dropType.getImage())
        let width = height * texture.size().width / texture.size().height
        let sprite = SKSpriteNode(texture: texture, size: CGSize(width: width, height: height))
        sprite.zPosition = -100
        super.init(sprite: sprite, radius: height / 2, position: position,
                   velocity: CGVector.zero, acceleration: CGVector(dx: 0, dy: gravity))
        
    }
    
}
