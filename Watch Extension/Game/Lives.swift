//
//  Lives.swift
//  Watch Extension
//
//  Created by Francisco Turdera on 1/26/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

class Lives {
    
    var numberRemaining: Int
    private var sprites: [SKSpriteNode]
    private var sprite: SKNode
    private var spriteTexture: SKTexture
    private static let HEIGHT: CGFloat = 0.1
    private static let SPACE: CGFloat = 0.05
    private var width: CGFloat
    private var height: CGFloat
    
    init(numberRemaining: Int = 3, height: CGFloat = Lives.HEIGHT, frame: CGRect) {
        
        let spriteTexture = SKTexture(imageNamed: "water_bottle")
        self.spriteTexture = spriteTexture
        let width = height * spriteTexture.size().width / spriteTexture.size().height
        self.width = width
        self.height = height
        self.sprites = []
        self.sprite = SKNode()
        self.sprite.position = CGPoint(x: frame.minX, y: frame.maxY)
        
        for i in 0..<numberRemaining {
            
            let waterSprite = SKSpriteNode(texture: self.spriteTexture,
                                           size: CGSize(width: width, height: height))
            self.sprites.append(waterSprite)
            waterSprite.position = CGPoint(x: sprite.position.x + CGFloat(integerLiteral: i) * Lives.SPACE,
                                               y: sprite.position.y - waterSprite.size.height / 2)
            self.sprite.addChild(waterSprite)
            
        }
        
        
        self.numberRemaining = numberRemaining
        
    }
    
    private func addLife() {
        
        
        let waterSprite = SKSpriteNode(texture: self.spriteTexture,
                                       size: CGSize(width: width, height: height))
        self.sprites.append(waterSprite)
        waterSprite.position = CGPoint(x: sprite.position.x +
            CGFloat(integerLiteral: (numberRemaining - 1)) * Lives.SPACE,
                                       y: sprite.position.y - waterSprite.size.height / 2)
        self.sprite.addChild(waterSprite)
        
    }
    
    private func removeLife() {
        
        
        
    }
    
    func addLivesToScene(toScene scene: SKScene) {
        
        scene.addChild(sprite)
        
    }
}
