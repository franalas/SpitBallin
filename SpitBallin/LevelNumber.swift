//
//  LevelNumber.swift
//  SpitBallin
//
//  Created by Liam Stevenson on 1/29/19.
//  Copyright © 2019 Stevera. All rights reserved.
//

import Foundation
import SpriteKit

/// Represents the levels of the game
//typealias Level = [Ball]
enum LevelNumber: Int, Level {
    
    
    /// Level one
    case one = 1
    
    /// Level two
    case two
    
    /// Level three
    case three
    
    /// Level four
    case four
    
    /// Level five
    case five
    
    /// Level six
    case six
    
    /// Level seven
    case seven
    
    /// Level eight
    case eight
    
    /// Level nine
    case nine
    
    var nextLevel: Level {
        if let nextLevel = LevelNumber(rawValue: self.rawValue + 1) { return nextLevel }
        else { return LevelNumber.one }
    }
    
    func makeLevel(gameSize: CGSize) -> [Ball] {
        
        let speed = 0.1 * gameSize.width
        
        switch self {
            
        case .one:
            return [Ball(ballSize: .two, positionX: 0.5 * gameSize.width, gameSize: gameSize, speed: speed)]
        case .two:
            return [Ball(ballSize: .three, positionX: 0.5 * gameSize.width, gameSize: gameSize, speed: speed)]
        case .three:
            return [Ball(ballSize: .one, positionX: 0.1 * gameSize.width, gameSize: gameSize, speed: speed),
                    Ball(ballSize: .one, positionX: 0.2 * gameSize.width, gameSize: gameSize, speed: speed),
                    Ball(ballSize: .one, positionX: 0.3 * gameSize.width, gameSize: gameSize, speed: speed),
                    Ball(ballSize: .one, positionX: 0.7 * gameSize.width, gameSize: gameSize, right: false,
                         speed: speed),
                    Ball(ballSize: .one, positionX: 0.8 * gameSize.width, gameSize: gameSize, right: false,
                         speed: speed),
                    Ball(ballSize: .one, positionX: 0.9 * gameSize.width, gameSize: gameSize, right: false,
                         speed: speed)]
        case .four:
            return [Ball(ballSize: .three, positionX: 0.3 * gameSize.width, gameSize: gameSize, right: false,
                         speed: speed),
                    Ball(ballSize: .two, positionX: 0.7 * gameSize.width, gameSize: gameSize, speed: speed)]
        case .five:
            return [Ball(ballSize: .two, positionX: 0.2 * gameSize.width, gameSize: gameSize, speed: speed),
                    Ball(ballSize: .two, positionX: 0.5 * gameSize.width, gameSize: gameSize, speed: speed),
                    Ball(ballSize: .three, positionX: 0.7 * gameSize.width, gameSize: gameSize, speed: speed)]
        case .six:
            return [Ball(ballSize: .four, positionX: 0.5 * gameSize.width, gameSize: gameSize, speed: speed)]
        case .seven:
            return [Ball(ballSize: .four, positionX: 0.2 * gameSize.width, gameSize: gameSize, speed: speed),
                    Ball(ballSize: .two, positionX: 0.8 * gameSize.width, gameSize: gameSize, right: false,
                         speed: speed)]
        case .eight:
            return [Ball(ballSize: .five, positionX: 0.5 * gameSize.width, gameSize: gameSize, speed: speed)]
        case .nine:
            return [Ball(ballSize: .five, positionX: 0.2 * gameSize.width, gameSize: gameSize, speed: speed),
                    Ball(ballSize: .five, positionX: 0.7 * gameSize.width, gameSize: gameSize, right: false,
                        speed: speed)]
            
        }
        
    }
    
}
