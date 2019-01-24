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
    
    /// The player sprite
    private let player: Player
    
    /// The ball sprites
//    private let balls: [Ball]
    
    /// The bullet sprites
//    private let bullets: [Bullet]
    
    // MARK: Initializers
    
    override init() {
        
        self.player = Player(height: GameScene.PLAYER_HEIGHT, person: .liam)
        
        super.init()
        
        setupLevel()
        
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
        
        player.xPosition += CGFloat(value * GameScene.CROWN_MULTIPLIER)
        
    }
    
    /**
    Shoots shot.
    */
    func shoot() {
        
        
        
    }
    
    // MARK: Game logic
    
    /**
     Makes Ball input disappear and creates 2 Balls with one size smaller or none if minimum size
     */
    private func split(givenBall: Ball) {
        
        
        
    }
    
    /**
    Sets up level (player position, initial balls)
    */
    private func setupLevel() {
        
    }
    
    /**
    Resets to the start of the level
    */
    func resetLevel() {
        
        setupLevel()
        
    }
    
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        

    }
    
}
