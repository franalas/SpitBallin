//
//  Level.swift
//  SpitBallin
//
//  Created by Liam Stevenson on 1/29/19.
//  Copyright © 2019 Stevera. All rights reserved.
//

import Foundation
import SpriteKit

/// Handles level creation and progression
protocol Level {
    
    /// The next level after the current one
    var nextLevel: Level { get }
    
    
    /// Creates the level
    ///
    /// - Parameter gameSize: The size of the game scene
    /// - Returns: The balls that go in the level
    func makeLevel(gameSize: CGSize) -> [Ball]
    
    /// Possibly spawns more balls
    ///
    /// - Parameter ballScore: The count of balls remaining, weighted on their size
    /// - Parameter gameSize: The size of the game scene
    /// - Returns: The balls to be spawned
    func spawnBalls(ballScore: Int, gameSize: CGSize) -> [Ball]
    
}
