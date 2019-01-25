//
//  GameScene.swift
//  Watch Extension
//
//  Created by Liam Stevenson on 1/24/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

/// A handler to receive frame updates from SKScene
class GameScene: SKScene {
    
    /// The `Game` object that handles this scene
    weak var game: Game?
    
    /// The last time to be passed to update
    private var lastTime: TimeInterval?
    
    override func update(_ currentTime: TimeInterval) {
        
        if let lastTime = self.lastTime { game?.update(currentTime - lastTime) }
        lastTime = currentTime
        
    }
    
}
