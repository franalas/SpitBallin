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
    
    // MARK: Settings
    
    /// How long the shot animation should last
    private static let SHOT_LENGTH: TimeInterval = 0.5
    
    // MARK: Fields
    
    /// The texture of the player when not shooting
    private var standardTexture: SKTexture?
    
    /// The texture of the player when shooting
    private var shootTexture: SKTexture?
    
    /// The position relative to self where the shot should originate
    let barrelPosition = CGPoint(x: 0, y: 0)
    
    /// The x position of the player
    var xPosition: CGFloat {

        get { return self.position.x }
        set {
            var x = newValue
            if newValue < 0 { x = 0 }
            else if newValue > 1 { x = 1 }
            self.position = CGPoint(x: x, y: self.position.y)
        }

    }
    
    // MARK: Initializers
    
    /**
    Initializes a Player as a given Person with a given height. The width will be made to keep the texture's aspect ratio.
    The player's y will be 0.
     - Parameters:
        - height: the height of the player in the scene
        - person: which character the player is
    */
    convenience init(height: CGFloat, person: Person) {
        
        let standardTexture = SKTexture(imageNamed: person.normalImage())
        let shootTexture = SKTexture(imageNamed: person.shootImage())
        let width = height * standardTexture.size().width / standardTexture.size().height
        
        self.init(texture: standardTexture, color: .clear, size: CGSize(width: width, height: height))
        self.standardTexture = standardTexture
        self.shootTexture = shootTexture
        self.anchorPoint = CGPoint(x: 0.5, y: 0)
        self.position = CGPoint.zero
        
        self.physicsBody = SKPhysicsBody(texture: standardTexture, size: self.size)
        self.physicsBody?.isDynamic = false
        
    }
    
    override private init(texture: SKTexture?, color: UIColor, size: CGSize) {

        super.init(texture: texture, color: color, size: size)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Player actions
    
    /**
    Animates the player sprite shooting.
     - Parameters:
        - completion: called when animation finishes
    */
    func animateShot(_ completion: (() -> Void)?) {
        
        self.run(.sequence([
            .setTexture(shootTexture!),
            .wait(forDuration: Player.SHOT_LENGTH),
            .setTexture(standardTexture!)
            ]), completion: completion ?? {})
        
    }
    
}
