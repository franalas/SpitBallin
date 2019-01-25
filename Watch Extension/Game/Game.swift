//
//  Game.swift
//  Watch Extension
//
//  Created by Liam Stevenson on 1/24/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit
import WatchKit

/**
 Stores game state, handles game logic, and receives controls
 */
class Game {
    
    /// Pauses the game when set to `true`; defaults to `true`
    var paused: Bool = true {
        didSet { }
    }
    
    /// The character of the player
    var character: Person {
        get { return player.character }
        set { player.character = newValue }
    }
    
    /// The SKScene that the game is in
    private var scene: SKScene
    
    /// The player on the bottom of the screen
    private var player: Player!
    
    /// All bullets in the scene
    private var bullets: [Bullet]!
    
    /// All bullets in the scene
    private var balls: [Ball]!
    
    /**
     Initializes a game with a given scene size and starting character
     - Parameters:
        - size: the size of the game scene
        - person: the player's starting character
    */
    init(size: CGSize, person: Person) {
        
        self.scene = SKScene(size: size)
        self.setupGame()
        
    }
    
    /// Sets up game with its initial state
    private func setupGame() {
        
        self.player = Player(person: self.character, frame: self.scene.frame)
        self.scene.addChild(self.player.sprite)
        self.bullets = []
        
        self.balls = [Ball(ballSize: .one, color: .red, position: CGPoint(x: 0.4, y: 0.5))]
        for ball in balls { self.scene.addChild(ball.sprite) }
        
    }
    
    /// Shoots a bullet out of the player
    public func shoot() {
        
        let bullet = Bullet(position: CGPoint(x: player.mouth, y: 0))
        self.scene.addChild(bullet.sprite)
        self.bullets.append(bullet)
        self.player.animateShot()
        
    }
    
    /**
     Moves a player right or left a certain distance
     - Parameters:
        - value: A measurement of how far to move the player.
        This value is scaled to a value, and the player's x position changes by that much
    */
    public func movePlayer(_ value: Double) { }
    
    /**
     Presents the game in a `WKInterfaceSKScene`
     - Parameters:
        - inInterface: the `WKInterfaceSKScene` that the game should be presented in
    */
    func present(inInterface: WKInterfaceSKScene) {
        
//        inInterface.preferredFramesPerSecond = 30
        
    }
    
    /**
     Resets the game back to its initial state
    */
    func restart() {
        
        self.player?.sprite.removeFromParent()
        self.player = nil
        
        if let bullets = bullets {
            for bullet in bullets {
                bullet.sprite.removeFromParent()
            }
            self.bullets = nil
        }
        
        if let balls = balls {
            for ball in balls {
                ball.sprite.removeFromParent()
            }
            self.balls = nil
        }
        
    }
    
}
