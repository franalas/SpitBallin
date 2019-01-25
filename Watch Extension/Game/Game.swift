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
        get { return Person.liam }
        set { }
    }
    
    /**
     Initializes a game with a given scene size
     - Parameters:
        - size: the size of the game scene
    */
    init(size: CGSize) { }
    
    /// Shoots a bullet out of the player
    public func shoot() { }
    
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
    func restart() { }
    
}
