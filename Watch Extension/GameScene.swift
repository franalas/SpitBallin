//
//  GameScene.swift
//  Watch Extension
//
//  Created by Liam Stevenson on 1/23/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    /**
    Moves the player left or right. Will stop at a wall.
    - Parameters:
      - value: how far to move the player
    */
    func movePlayer(_ value: Double) {
        
        movePlayerSprite(distance: CGFloat(value))
        
    }
    
    /**
    Shoots shot.
    */
    func shoot() {
        
        shootFromPlayer()
        
    }
    
    /**
    Moves the player the given distance. Stops at a wall.
    - Parameters:
      - distance: how far to move the player
    */
    private func movePlayerSprite(distance: CGFloat) {
        
        
        
    }
    
    /**
    Shoots a shot upwards out of the player object.
    */
    private func shootFromPlayer() {
        
        
        
    }
    
}
