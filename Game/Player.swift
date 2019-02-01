//
//  Player.swift
//  Watch Extension
//
//  Created by Liam Stevenson on 1/24/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

class Player: CircularObject {
    
    /// How tall the player is by default, as a percentage of the game scene's height
    static let HEIGHT_MULTIPLIER: CGFloat = 0.225
    
    /// How long the shoot animation lasts
    static let SHOT_LENGTH = 0.5
    
    /// How long the bubble growing animation lasts
    static let BUBBLE_GROW_LENGTH = 1.0
    
    /// How long the bubble popping animation lasts
    static let BUBBLE_POP_LENGTH = 1.0
    
    /// Keeps track of how many lives a Player has
    private let lifeBar: Lives
    
    /// Represents how many lives the a Player has left
    var lives: Int {
        
        get { return lifeBar.numberRemaining }
        
        set { lifeBar.numberRemaining = newValue }
        
    }
    
    var sprite: SKNode
    var radius: CGFloat
    var position: CGPoint { return self.sprite.position }
    
    /// If true, the player currently has a shield
    var hasShield: Bool { return shieldState != .none }
    
    /// Holds which shield state player is currently in
    private var shieldState = ShieldState.none
    
    /// Represents various states of the shield growing and popping
    private enum ShieldState {
        case none, growing, shield, popping
    }
    
    /// The sprite that represents the shield around the player
    private let shieldSprite: SKSpriteNode
    
    /// The radius of the shield sprite
    private let shieldRadius: CGFloat
    
    /// The alpha value for the shield
    static let SHIELD_ALPHA: CGFloat = 0.5
    
    /// The position of the player's mouth relative to the scene
    var mouth: CGPoint { return self.sprite.parent!.convert(mouthRelativeToPlayer, from: self.sprite) }
    
    /// The position of the player's mouth relative to the player sprite
    private let mouthRelativeToPlayer: CGPoint
    
    /// The x-position of `self` in the scene
    var xPosition: CGFloat {
        get { return self.sprite.position.x }
        set {
            if newValue < minX { self.sprite.position = CGPoint(x: minX, y: self.sprite.position.y) }
            else if newValue > maxX { self.sprite.position = CGPoint(x: maxX, y: self.sprite.position.y) }
            else { self.sprite.position = CGPoint(x: newValue, y: self.sprite.position.y) }
            
        }
    }
    
    /// The character used for `self`
    var character: Person {
        didSet {
            self.standardTexture = SKTexture(imageNamed: character.normalImage())
            self.shootTexture = SKTexture(imageNamed: character.shootImage())
            self.shutTexture = SKTexture(imageNamed: character.shutImage())
            (self.sprite as! SKSpriteNode).texture = self.standardTexture
        }
    }
    
    /// Tracks the player's score
    var score: Int
    
    /// The texture of the sprite when not shooting
    private var standardTexture: SKTexture
    
    /// The texture of the sprite when shooting
    private var shootTexture: SKTexture
    
    /// The texture of the sprite when max bullets are in the air
    private var shutTexture: SKTexture
    
    /// Tracks whether the current texture is shut or unshut
    var currentlyShut: Bool {
        didSet {
            if oldValue && !currentlyShut { (self.sprite as? SKSpriteNode)?.run(.setTexture(self.standardTexture)) }
        }
    }
    
    /// The farthest right the player can move
    private let maxX: CGFloat
    
    /// The farthest left the player can move
    private let minX: CGFloat
    
    /**
     Initializes a `Player` object with a given character and screen bounds
     - Parameters:
        - person: The character that the player should be
        - frame: The bounds of the screen
        - lives: Lives associated with Player
    */
    init(person: Person, frame: CGRect) {
        
        self.character = person
        
        self.standardTexture = SKTexture(imageNamed: person.normalImage())
        self.shootTexture = SKTexture(imageNamed: person.shootImage())
        self.shutTexture = SKTexture(imageNamed: person.shutImage())
        currentlyShut = false
        
        self.lifeBar = Lives(frame: frame)
        
        self.score = 0
        
        let width = frame.height * Player.HEIGHT_MULTIPLIER * standardTexture.size().width / standardTexture.size().height
        let height = frame.height * Player.HEIGHT_MULTIPLIER
        let sprite = SKSpriteNode(texture: self.standardTexture, size: CGSize(width: width, height: height))
        self.sprite = sprite
        
        self.radius = sprite.size.height / 4
        
        self.sprite.position = CGPoint(x: frame.midX, y: frame.minY + sprite.size.height / 2)
        
        self.mouthRelativeToPlayer = CGPoint(x: 0, y: -sprite.size.height / 4)
        
        self.minX = frame.minX + radius
        self.maxX = frame.maxX - radius
        
        let shieldTexture = SKTexture(imageNamed: "bubble")
        self.shieldRadius = height / 2
        self.shieldSprite = SKSpriteNode(texture: shieldTexture, size: CGSize(width: 2*shieldRadius, height: 2*shieldRadius))
        self.shieldSprite.alpha = 0
        self.sprite.addChild(self.shieldSprite)
        
    }
    
    /// Animates the player sprite shooting.
    func animateShot() {
        
        (self.sprite as! SKSpriteNode).run(.sequence([
            .setTexture(self.shootTexture),
            .wait(forDuration: Player.SHOT_LENGTH),
            .run {
                (self.sprite as! SKSpriteNode).run(.setTexture(self.currentlyShut ? self.shutTexture : self.standardTexture))
            }]))
        
    }
    
    /**
     Adds LifeImplementation to the scene
     - Parameters:
        - scene: scene where LifeImplementation is added to
     */
    func addLivesToScene(toScene scene: SKScene) {
        
        lifeBar.addLivesToScene(toScene: scene)
        
    }
    
    /**
     Makes the player animate growing a shield around them if the player does not already have a shield
    */
    func growShield() {
        
        guard !self.hasShield else { return }
        self.shieldState = .growing
        
        self.shieldSprite.size = CGSize.zero
        self.shieldSprite.alpha = Player.SHIELD_ALPHA
        self.shieldSprite.position = mouthRelativeToPlayer
        
        self.shieldSprite.run(
            .sequence([
                .group([
                    .resize(toWidth: 2*shieldRadius, duration: Player.BUBBLE_GROW_LENGTH),
                    .resize(toHeight: 2*shieldRadius, duration: Player.BUBBLE_GROW_LENGTH),
                    .move(to: CGPoint.zero, duration: Player.BUBBLE_GROW_LENGTH)
                    ]),
                .run {
                    self.shieldState = .shield
                }]), withKey: "growing")
        
    }
    
    /**
     Makes the player animate losing their shield them if they do not already have a shield
    */
    func destroyShield() {
        
        switch self.shieldState {
        case .none, .popping:
            break
        case .growing:
            self.shieldSprite.removeAction(forKey: "growing")
            self.shieldSprite.size = CGSize(width: 2*shieldRadius,
                                            height: 2*shieldRadius)
            fallthrough
        case .shield:
            self.shieldState = .popping
            self.shieldSprite.run(
                .sequence([
                    .fadeOut(withDuration: Player.BUBBLE_POP_LENGTH / 5),
                    .fadeAlpha(to: Player.SHIELD_ALPHA, duration: Player.BUBBLE_POP_LENGTH / 5),
                    .fadeOut(withDuration: Player.BUBBLE_POP_LENGTH / 5),
                    .fadeAlpha(to: Player.SHIELD_ALPHA, duration: Player.BUBBLE_POP_LENGTH / 5),
                    .fadeOut(withDuration: Player.BUBBLE_POP_LENGTH / 5),
                    .run {
                        self.shieldState = .none
                    }]), withKey: "popping")
        }
        
    }
    
    /// Takes away the player's shield immediately without animation
    func resetShield() {
        
        self.shieldSprite.removeAction(forKey: "growing")
        self.shieldSprite.removeAction(forKey: "popping")
        
        self.shieldSprite.alpha = 0
        self.shieldState = .none
        
    }
    
}

