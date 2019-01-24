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
    private var player: Player?
    
    /// The ball sprites
    private var balls: [Ball] = []
    
    /// The bullet sprites
//    private let bullets: [Bullet]
    
    // MARK: Initializers
    
    override init(size: CGSize) {

        super.init(size: size)
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
        
        player?.xPosition += CGFloat(value * GameScene.CROWN_MULTIPLIER)
        
    }
    
    /**
    Shoots shot
    */
    func shoot() {
        
        
        
    }
    
    // MARK: Game logic
    
    /**
     Makes Ball input disappear and creates 2 Balls with one size smaller or none if minimum size
     */
    private func split(ball: Ball) {
        
        balls = balls.filter { $0 !== ball }
        ball.removeFromParent()
        if let (ball1, ball2) = ball.split() {
            
            balls.append(ball1)
            balls.append(ball2)
            self.addChild(ball1)
            self.addChild(ball2)
            
        }
        
    }
    
    /**
    Sets up level (player position, initial balls)
    */
    private func setupLevel() {
        
        if self.player == nil {
            self.player = Player(height: GameScene.PLAYER_HEIGHT, person: .liam)
            self.addChild(player!)
        }
        player!.xPosition = GameScene.PLAYER_START_X
        
        balls = [Ball(ballSize: .one, color: .red, position: CGPoint(x: 0.4, y: 0.5), velocity: CGVector(dx: -0.3, dy: 0)),
                 Ball(ballSize: .one, color: .red, position: CGPoint(x: 0.6, y: 0.5), velocity: CGVector(dx: 0.3, dy: 0))]
        for ball in balls { self.addChild(ball) }
        
    }
    
    /**
    Resets to the start of the level
    */
    func resetLevel() {
        
        self.removeAllChildren()
        self.balls = []
        setupLevel()
        
    }
    
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        

    }
    
}
