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
    
    /// How much the digital crown rotational delta is multiplier by to determine amount of player movement
    private static let CROWN_MULTIPLIER: CGFloat = 0.5
    
    /// Pauses the game when set to `true`; defaults to `true`
    var paused: Bool = true
    
    /// The character of the player
    var character: Person {
        didSet { player.character = character }
    }
    
    /// The SKScene that the game is in
    private var scene: SKScene
    
    /// The player on the bottom of the screen
    private var player: Player!
    
    /// All bullets in the scene
    private var bullets: [Bullet]?
    
    /// All bullets in the scene
    private var balls: [Ball]?
    
    /// The current level of the game
    private(set) var currentLevel: LevelNumber?
    
    /// The maximum number of shots allowed on the screen at a time
    private static let MAXSHOTS = 3
    
    /**
     Initializes a game with a given scene size and starting character
     - Parameters:
        - size: the size of the game scene
        - person: the player's starting character
    */
    init(size: CGSize, person: Person) {
        
        let gameScene = GameScene(size: size)
        self.scene = gameScene
        gameScene.backgroundColor = .black
        self.scene.scaleMode = .aspectFit
        self.character = person
        gameScene.game = self
        self.setupGame()
        
    }
    
    /// Sets up game with its initial state
    private func setupGame() {
        
        self.player = Player(person: self.character, frame: self.scene.frame)
        self.scene.addChild(self.player.sprite)
        
        self.bullets = []
        
        self.currentLevel = .one
        self.balls = currentLevel!.makeLevel()
        for ball in balls ?? [] { self.scene.addChild(ball.sprite) }
        
    }
    
    /// Shoots a bullet out of the player
    func shoot() {
        
        if !paused && self.bullets!.count < Game.MAXSHOTS {
                
            let bullet = Bullet(position: player.mouth, distanceToTop: self.scene.size.height - self.player.mouth.y)
            self.scene.addChild(bullet.sprite)
            self.bullets?.append(bullet)
            self.player.currentlyShut = self.bullets!.count >= Game.MAXSHOTS
            self.player.animateShot()
            
        }
        
    }
    
    /**
     Moves a player right or left a certain distance
     - Parameters:
        - value: A measurement of how far to move the player.
        This value is scaled to a value, and the player's x position changes by that much
    */
    func movePlayer(_ value: Double) {
        
        if !paused { player.xPosition += CGFloat(value) * Game.CROWN_MULTIPLIER }
        
    }
    
    /**
     Presents the game in a `WKInterfaceSKScene`
     - Parameters:
        - inInterface: the `WKInterfaceSKScene` that the game should be presented in
    */
    func present(inInterface: WKInterfaceSKScene) {
        
        inInterface.presentScene(self.scene)
        inInterface.preferredFramesPerSecond = 30
        
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
        
        setupGame()
        
    }
    
    /// Loads the next level of the game; assumes all balls have been removed
    func loadNextLevel() {
        
        for bullet in bullets ?? [] {
            bullet.sprite.removeFromParent()
        }
        self.bullets = []
        
        self.player.xPosition = 0.5
        
        self.currentLevel = (self.currentLevel ?? .one).nextLevel
        self.balls = self.currentLevel!.makeLevel()
        for ball in self.balls! { self.scene.addChild(ball.sprite) }
        
    }
    
    /**
     Handles frame updates
     - Parameters:
        - timeInterval: how much time has passed since last frame
    */
    func update(_ timeInterval: TimeInterval) {
        
        if !paused {
            
            checkCollisions()
            tickObjects(timeInterval)
            
        }
        
    }
    
    /// Handles collision detection
    private func checkCollisions() {
            
        let frame = self.scene.frame
        var ballI = (balls?.count ?? 0) - 1
        while ballI >= 0 { //check if ball collides with player or any bullets
            
            if ballI < 0 || ballI >= balls!.count { break }
            balls![ballI].bounceFloor(rect: frame)
            balls![ballI].bounceWall(rect: frame)
                
            if Player.checkCollision(player, balls![ballI]) {
                
                handleDeath(fromBall: balls![ballI])
                
            } else {
                
                var bulletI = (bullets?.count ?? 0) - 1
                while bulletI >= 0 {
                    
                    if bulletI < 0 || bulletI >= bullets!.count || ballI < 0 || ballI >= balls!.count { break }
                    if DynamicCircularObject.checkCollision(balls![ballI], bullets![bulletI]) {
                            
                        self.split(ballAtIndex: ballI)
                        remove(bulletAtIndex: bulletI)
                        
                    }
                    bulletI -= 1
                    
                }
                
            }
                
            ballI -= 1
            
        }
        
        var bulletI = (bullets?.count ?? 0) - 1
        while bulletI >= 0 { //check if any bullets hit the floor
            
            if bullets![bulletI].floorCollision(rect: frame) {
                
                remove(bulletAtIndex: bulletI)
                
            }
            bulletI -= 1
            
        }
        
    }
    
    /**
     Updates balls and bullets with game tick
     - Parameters:
        - timeInterval: the amount of time since last frame
    */
    private func tickObjects(_ timeInterval: TimeInterval) {
        
        for ball in balls ?? [] { ball.tick(time: CGFloat(timeInterval)) }
        for bullet in bullets ?? [] { bullet.tick(time: CGFloat(timeInterval)) }
        
    }
    
    /**
     Splits the ball at the given index
     - Parameters:
        - i: the index in `balls` of the ball to be split
    */
    private func split(ballAtIndex i: Int) {
        
        if let (nextA, nextB) = balls?[i].split() {
            self.balls?.append(nextA)
            self.balls?.append(nextB)
            self.scene.addChild(nextA.sprite)
            self.scene.addChild(nextB.sprite)
        }
        balls?[i].sprite.removeFromParent()
        balls?.remove(at: i)
        
        if (self.balls?.count ?? 1) == 0 { loadNextLevel() }
        
    }
    
    /**
     Removes the bullet at the given index from game
     - Parameters:
        - i: the index in `bullets` of the bullet to be removed
     */
    private func remove(bulletAtIndex i: Int) {
        
        guard i >= 0 && i < (self.bullets?.count ?? 0) else { return }
        self.bullets?[i].sprite.removeFromParent()
        self.bullets?.remove(at: i)
        
        if (self.bullets?.count ?? 0) < Game.MAXSHOTS { self.player.currentlyShut = false }
        
    }
    
    /**
     Handles a player death
     - Parameters:
        - fromBall: the ball the player was hit by
    */
    private func handleDeath(fromBall: Ball) {
        
        self.restart()
        
    }
    
}
