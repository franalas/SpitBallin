//
//  Player.swift
//  Watch Extension
//
//  Created by Liam Stevenson on 1/23/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

/// Represents a player sprite in the game
class Player: SKSpriteNode {
    
    /// The texture of the player when not shooting
    private var standardTexture: SKTexture?
    /// The texture of the player when shooting
    private var shootTexture: SKTexture?
    
    /**
    Initializes a Player as a given Person with a given size
     - Parameters:
        - size: the size of the player in the scene
        - person: which character the player is
    */
    convenience init(size: CGSize, person: Person) {
        
        let standardTexture = SKTexture(imageNamed: person.normalImage())
        let shootTexture = SKTexture(imageNamed: person.shootImage())
        self.init(texture: standardTexture, color: .clear, size: size)
        self.standardTexture = standardTexture
        self.shootTexture = shootTexture
        
    }
    
    override private init(texture: SKTexture?, color: UIColor, size: CGSize) {

        super.init(texture: texture, color: color, size: size)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
    Will animate the player sprite shooting.
    */
    func animateShot() {
        
    }
    
    /**
    Moves the player left or right the given distance.
     - Parameters:
        - distance: how far to move the player
    */
    func move(distance: CGFloat) {
        
        
        
    }
    
}
