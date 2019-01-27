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
    
    var numberRemaining: Int {
        didSet {
            print("\(numberRemaining)")
            for i in 0..<sprites.count {
                sprites[i].isHidden = i >= numberRemaining
            }
        }
    }
    private var sprites: [SKSpriteNode]
    private var sprite: SKNode
    private var spriteTexture: SKTexture
    private static let HEIGHT: CGFloat = 0.1
    private static let SPACE: CGFloat = 0.05
    private var width: CGFloat
    private var height: CGFloat
    private static let MAXLIVES: Int = 7
    static let STARTINGLIVES: Int = 3
    
    init(frame: CGRect, startingLives: Int = Lives.STARTINGLIVES, maxLives: Int = Lives.MAXLIVES,
         height: CGFloat = Lives.HEIGHT) {
        
        let spriteTexture = SKTexture(imageNamed: "water_bottle")
        self.spriteTexture = spriteTexture
        let width = height * spriteTexture.size().width / spriteTexture.size().height
        self.width = width
        self.height = height
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
    
//    private func addLife() {
//        
//        numberRemaining += 1
//        self.sprites[numberRemaining - 1].isHidden = false
//
//    }
//
//    private func removeLife() {
//
//        self.sprites[numberRemaining - 1].isHidden = true
//        numberRemaining -= 1
//
//    }
    
    func addLivesToScene(toScene scene: SKScene) {
        
        scene.addChild(sprite)
        
        for s in self.sprites {
            print(self.sprite.convert(s.position, to: scene))
        }
        
    }
}
