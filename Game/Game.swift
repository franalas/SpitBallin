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


 /// Stores game state, handles game logic, and receives controls
class Game {
    
    /// Pauses the game when set to `true`; defaults to `true`
    var paused: Bool = true {
        didSet {
            pauseIndicator.isHidden = !paused
        }
    }
    
    /// The character of the player
    var character: Person {
        didSet { player.character = character }
    }
    
    /// The speed at which the player moves left/right
    var movementSpeed = CGFloat(5)
    
    /// If true, the player will move left on game ticks
    var movingLeft = false
    
    /// If true, the player will move right on game ticks
    var movingRight = false
    
    /// The player's score
    var score: Int { return player.score }
    
    /// The SKScene that the game is in
    private var scene: GameScene
    
    /// The player on the bottom of the screen
    private var player: Player
    
    /// All bullets in the scene
    private var bullets: [Bullet]
    
    /// All bullets in the scene
    private var balls: [Ball]
    
    /// All drops in the scene
    private var drops: [Drop]
    
    /// Indicates whether or not the game is paused
    private var pauseIndicator: SKSpriteNode
    
    /// The first level of the game
    private var firstLevel: Level
    
    /// The current level of the game
    private var currentLevel: Level
    
    /// The maximum number of shots allowed on the screen at a time
    private static let MAXSHOTS = 1
    
    /**
     Initializes a game with a given scene size and starting character
     - Parameters:
     - size: the size of the game scene
     - person: the player's starting character
     */
    init(size: CGSize, person: Person, firstLevel: Level) {
        
        self.scene = GameScene(size: size)
        self.scene.backgroundColor = .black
        self.scene.scaleMode = .aspectFit
        
        let minDimension = min(size.width, size.height)
        self.pauseIndicator = SKSpriteNode(texture: SKTexture(imageNamed: "pause"), size: CGSize(width: 0.1 * minDimension, height: 0.1 * minDimension))
        self.pauseIndicator.position = CGPoint(x: 0.9 * size.width, y: 0.9 * size.height)
        self.scene.addChild(self.pauseIndicator)
        
        self.character = person
        self.player = Player(person: self.character, frame: self.scene.frame)
        self.scene.addChild(self.player.sprite)
        self.player.addLivesToScene(toScene: self.scene)
        
        self.bullets = []
        self.balls = []
        self.drops = []
        
        self.firstLevel = firstLevel
        self.currentLevel = firstLevel
        
        self.scene.game = self
        
        self.setup()
        
    }
    
    /**
     Sets up game on a given level
     - Parameters:
        - level: Decides what level game is set up to
        - lives: Decides how many lives the player has
     */
    private func setup(level: Level? = nil, withLives lives: Int = Lives.STARTING_LIVES) {
        
        self.player.xPosition = self.scene.frame.midX
        self.player.lives = lives
        self.player.currentlyShut = false
        
        for bullet in bullets { bullet.sprite.removeFromParent() }
        self.bullets = []
        for drop in drops { drop.sprite.removeFromParent() }
        self.drops = []
        
        for ball in balls { ball.sprite.removeFromParent() }
        self.currentLevel = level ?? firstLevel
        self.balls = currentLevel.makeLevel(gameSize: self.scene.size)
        for ball in balls { self.scene.addChild(ball.sprite) }
        
    }
    
    /// Shoots a bullet out of the player
    func shoot() {
        
        if !paused && self.bullets.count < Game.MAXSHOTS {
            
            let bullet = Bullet(gameSize: self.scene.size, position: player.mouth, distanceToTop: self.scene.size.height - self.player.mouth.y)
            self.scene.addChild(bullet.sprite)
            self.bullets.append(bullet)
            self.player.currentlyShut = self.bullets.count >= Game.MAXSHOTS
            self.player.animateShot()
            
        }
        
    }
    
    /**
     Moves a player right or left a certain distance
     - Parameters:
        - distance: How far to move the player
     This value is scaled to a value, and the player's x position changes by that much
     */
    func movePlayer(distance: CGFloat) {
        
        if !paused { player.xPosition += distance }
        
    }
    
    #if os(watchOS)
    /**
     Presents the game in a `WKInterfaceSKScene`
     - Parameters:
        - inInterface: the `WKInterfaceSKScene` that the game should be presented in
     */
    func present(inInterface: WKInterfaceSKScene) {
        
        inInterface.presentScene(self.scene)
        inInterface.preferredFramesPerSecond = 30
        
    }
    #endif
    
    #if os(iOS)
    /**
     Presents the game in a `SKView`
     - Parameters:
        - inView: the `SKView` that the game should be presented in
     */
    func present(inView: SKView) {
        
        inView.presentScene(self.scene)
        if #available(iOS 10.0, *) {
            inView.preferredFramesPerSecond = 30
        }
        
    }
    #endif
    
    /// Resets the game back to its initial state
    func restart() {
        
        setup()
        
    }
    
    /// Loads the next level of the game; assumes all balls have been removed
    func loadNextLevel() {
        
        self.setup(level: self.currentLevel.nextLevel, withLives: self.player.lives)
        
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
            
            if movingRight { movePlayer(distance: movementSpeed) }
            if movingLeft { movePlayer(distance: -movementSpeed) }
            
        }
        
    }
    
    /// Handles collision detection
    private func checkCollisions() {
        
        let frame = self.scene.frame
        var ballI = balls.count - 1
        while ballI >= 0 { //check if ball collides with player or any bullets
            
            guard ballI >= 0 && ballI < balls.count else { break }
            balls[ballI].bounceFloor(rect: frame)
            balls[ballI].bounceWall(rect: frame)
            
            if Player.checkCollision(player, balls[ballI]) {
                
                handleDeath(fromBall: balls[ballI])
                
            } else {
                
                var bulletI = bullets.count - 1
                while bulletI >= 0 {
                    
                    guard bulletI >= 0 && bulletI < bullets.count && ballI >= 0 && ballI < balls.count else { break }
                    if DynamicCircularObject.checkCollision(balls[ballI], bullets[bulletI]) {
                        
                        self.split(ballAtIndex: ballI)
                        remove(bulletAtIndex: bulletI)
                        
                    }
                    bulletI -= 1
                    
                }
                
            }
            
            ballI -= 1
            
        }
        
        var bulletI = bullets.count - 1
        while bulletI >= 0 { //check if any bullets hit the floor
            
            if bullets[bulletI].floorCollision(rect: frame) {
                
                remove(bulletAtIndex: bulletI)
                
            }
            bulletI -= 1
            
        }
        
        var dropI = drops.count - 1
        while dropI >= 0 { //check if any bullets hit the floor
            
            if drops[dropI].floorCollision(rect: frame) {
                
                drops[dropI].dropType.performAction(inGame: self)
                remove(dropAtIndex: dropI)
                
            }
            dropI -= 1
            
        }
        
    }
    
    /**
     Updates balls and bullets with game tick
     - Parameters:
        - timeInterval: the amount of time since last frame
     */
    private func tickObjects(_ timeInterval: TimeInterval) {
        
        let t = CGFloat(timeInterval)
        for ball in balls { ball.tick(time: t) }
        for bullet in bullets { bullet.tick(time: t) }
        for drop in drops { drop.tick(time: t) }
        
    }
    
    /**
     Splits the ball at the given index
     - Parameters:
        - i: the index in `balls` of the ball to be split
     */
    private func split(ballAtIndex i: Int) {
        
        var ballScore = 0
        for ball in balls { ballScore += ball.ballSize.rawValue }
        let (newBalls, drop) = currentLevel.handleSplit(ballSize: balls[i].ballSize, ballScore: ballScore,
                                                        position: balls[i].position, gameSize: self.scene.size)
        
        self.player.score += balls[i].ballSize.rawValue
        
        for ball in newBalls {
            self.scene.addChild(ball.sprite)
        }
        self.balls += newBalls
        
        if let drop = drop {
            
            self.drops.append(drop)
            self.scene.addChild(drop.sprite)
            
        }
        
        if let (nextA, nextB) = balls[i].split() {
            self.balls.append(nextA)
            self.balls.append(nextB)
            self.scene.addChild(nextA.sprite)
            self.scene.addChild(nextB.sprite)
        }
        balls[i].sprite.removeFromParent()
        balls.remove(at: i)
        
        if self.balls.count == 0 { loadNextLevel() }
        
    }
    
    /**
     Removes the bullet at the given index from game
     - Parameters:
        - i: the index in `bullets` of the bullet to be removed
     */
    private func remove(bulletAtIndex i: Int) {
        
        guard i >= 0 && i < self.bullets.count else { return }
        self.bullets[i].sprite.removeFromParent()
        self.bullets.remove(at: i)
        
        if self.bullets.count < Game.MAXSHOTS { self.player.currentlyShut = false }
        
    }
    
    /**
     Removes the drop at the given index from game
     - Parameters:
        - i: the index in `drops` of the drop to be removed
     */
    private func remove(dropAtIndex i: Int) {
        
        guard i >= 0 && i < self.drops.count else { return }
        self.drops[i].sprite.removeFromParent()
        self.drops.remove(at: i)
        
    }
    
    /**
     Handles a player death
     - Parameters:
        - fromBall: the ball the player was hit by
     */
    private func handleDeath(fromBall: Ball) {
        
        if(player.lives <= 1) {
            
            self.restart()
            
        } else {
            
            player.lives -= 1
            self.setup(level: self.currentLevel, withLives: self.player.lives)
            
        }
        
    }
    
}
