//
//  Player.swift
//  Watch Extension
//
//  Created by Liam Stevenson on 1/24/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

class Player: CircularObject {
    
    /// How tall the player is by default
    private static let HEIGHT: CGFloat = 0.2
    
    /// How long the shoot animation lasts
    private static let SHOT_LENGTH = 0.5
    
    var sprite: SKNode
    var radius: CGFloat
    var position: CGPoint { return self.sprite.position }
    
    /// Returns the position of the mouth
    var mouth: CGPoint { return CGPoint(x: self.xPosition, y: position.y + radius/2) }
    
    /// The x-position of `self` in the scene
    var xPosition: CGFloat {
        get { return self.sprite.position.x }
        set {
            if newValue < minX { self.sprite.position = CGPoint(x: minX, y: self.sprite.position.y) }
            if newValue > maxX { self.sprite.position = CGPoint(x: maxX, y: self.sprite.position.y) }
            self.sprite.position = CGPoint(x: newValue, y: self.sprite.position.y)
            
        }
    }
    
    /// The character used for `self`
    var character: Person {
        didSet {
            self.standardTexture = SKTexture(imageNamed: character.normalImage())
            self.shootTexture = SKTexture(imageNamed: character.shootImage())
            (self.sprite as! SKSpriteNode).texture = self.standardTexture
        }
    }
    
    /// The texture of the sprite when not shooting
    private var standardTexture: SKTexture
    
    /// The texture of the sprite when shooting
    private var shootTexture: SKTexture
    
    /// The farthest right the player can move
    private let maxX: CGFloat
    
    /// The farthest left the player can move
    private let minX: CGFloat
    
    /**
     Initializes a `Player` object with a given character and screen bounds
     - Parameters:
        - person: The character that the player should be
        - frame: The bounds of the screen
    */
    init(person: Person, frame: CGRect, height: CGFloat = Player.HEIGHT) {
        
        self.character = person
        
        self.standardTexture = SKTexture(imageNamed: person.normalImage())
        self.shootTexture = SKTexture(imageNamed: person.shootImage())
        
        let width = height * standardTexture.size().width / standardTexture.size().height
        
        let sprite = SKSpriteNode(texture: self.standardTexture, size: CGSize(width: width, height: height))
        self.sprite = sprite
        
        self.radius = sprite.size.height / 2
        
        self.sprite.position = CGPoint(x: frame.midX, y: frame.minY + self.radius)
        
        self.minX = frame.minX
        self.maxX = frame.maxX
        
    }
    
    /**
     Animates the player sprite shooting.
     - Parameters:
     - completion: called when animation finishes
     */
    func animateShot(_ completion: (() -> Void)? = nil) {
        
        (self.sprite as! SKSpriteNode).run(.sequence([
            .setTexture(self.shootTexture),
            .wait(forDuration: Player.SHOT_LENGTH),
            .setTexture(standardTexture)
            ]), completion: completion ?? {})
        
    }
    
}

