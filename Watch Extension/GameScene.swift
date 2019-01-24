//
//  GameScene.swift
//  Watch Extension
//
//  Created by Liam Stevenson on 1/23/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // MARK: Settings
    
    /// The value by which the crown rotational delta is multiplied to determine movement distance
    private static let CROWN_MULTIPLIER = 0.1
    
    /// The height of the player sprite
    private static let PLAYER_HEIGHT: CGFloat = 0.2
    
    /// The starting x position of the player
    private static let PLAYER_START_X: CGFloat = 0.5
    
    // MARK: Fields
    
    private let player: Player
    
    // MARK: Initializers
    
    override init() {
        
        self.player = Player(height: GameScene.PLAYER_HEIGHT, x: GameScene.PLAYER_START_X, person: .liam)
        
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Control inputs
    
    /**
    Moves the player left or right. Will stop at a wall.
    - Parameters:
      - value: how far to move the player
    */
    func movePlayer(_ value: Double) {
        
        player.move(distance: CGFloat(value * GameScene.CROWN_MULTIPLIER))
        
    }
    
    /**
    Shoots shot.
    */
    func shoot() {
        
        
        
    }
    
    // MARK: Game logic
    
    /**
    Resets to the start of the level
    */
    func resetLevel() {
        
        
        
    }
    
}
