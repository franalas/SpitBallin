//
//  Lives.swift
//  Watch Extension
//
//  Created by Francisco Turdera on 1/26/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

/// Represents the lives the player has
class Lives {
    
    /// Value that holds how many lives the player has left. Sets any sprites outside range invisible
    var numberRemaining: Int {
        didSet {
            for i in 0..<sprites.count {
                sprites[i].isHidden = i >= numberRemaining
            }
        }
    }
    
    /// Represents each individual life sprite
    private var sprites: [SKSpriteNode]
    /// Parent to sprites, represents what is seen in scene
    private var sprite: SKNode
    /// Represents the texture the sprite contains
    private var spriteTexture: SKTexture
    /// Height of sprite
    private static let HEIGHT: CGFloat = 0.1
    /// Space in between life sprites
    private static let SPACE: CGFloat = 0.05
    /// Max number of lives a player can have
    private static let MAXLIVES: Int = 7
    /// Amount of lives a player begins with
    static let STARTINGLIVES: Int = 3
    
    /**
     Initializes Lives with given scene and values
     - Parameters:
        - frame: represents the scene where self will be located
        - startingLives: Amount of lives a player begins with
        - maxLives: Max number of lives a player can have
        - height: Height of a sprite
     */
    init(frame: CGRect, startingLives: Int = Lives.STARTINGLIVES, maxLives: Int = Lives.MAXLIVES,
         height: CGFloat = Lives.HEIGHT) {
        
        let spriteTexture = SKTexture(imageNamed: "water_bottle")
        self.spriteTexture = spriteTexture
        let width = height * spriteTexture.size().width / spriteTexture.size().height
        self.sprites = []
        self.sprite = SKNode()
        self.sprite.position = CGPoint(x: frame.minX + width/2, y: frame.maxY)
        
        for i in 0..<maxLives {
            
            let waterSprite = SKSpriteNode(texture: self.spriteTexture,
                                           size: CGSize(width: width, height: height))
            self.sprites.append(waterSprite)
            waterSprite.position = CGPoint(x: (CGFloat(i) + 0.5)*width + (CGFloat(i) + 0.5)*Lives.SPACE,
                                           y: -waterSprite.size.height / 2)
            if i > startingLives - 1 {
                waterSprite.isHidden = true
            }
            self.sprite.addChild(waterSprite)
            
        }
        
        self.numberRemaining = startingLives
        
    }
    
    /**
     Adds Lives object to a given scene
     - Parameters:
        - scene: scene where self will be located
     */
    func addLivesToScene(toScene scene: SKScene) {
        
        scene.addChild(sprite)
        
    }
}
