//
//  LevelNumber.swift
//  Watch Extension
//
//  Created by Liam Stevenson on 1/25/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
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
        
        switch self {
            
        case .one:
            return [Ball(ballSize: .two, positionX: 0.5 * gameSize.width, gameSize: gameSize)]
        case .two:
            return [Ball(ballSize: .three, positionX: 0.5 * gameSize.width, gameSize: gameSize)]
        case .three:
            return [Ball(ballSize: .one, positionX: 0.1 * gameSize.width, gameSize: gameSize),
                    Ball(ballSize: .one, positionX: 0.2 * gameSize.width, gameSize: gameSize),
                    Ball(ballSize: .one, positionX: 0.3 * gameSize.width, gameSize: gameSize),
                    Ball(ballSize: .one, positionX: 0.7 * gameSize.width, gameSize: gameSize, right: false),
                    Ball(ballSize: .one, positionX: 0.8 * gameSize.width, gameSize: gameSize, right: false),
                    Ball(ballSize: .one, positionX: 0.9 * gameSize.width, gameSize: gameSize, right: false)]
        case .four:
            return [Ball(ballSize: .three, positionX: 0.3 * gameSize.width, gameSize: gameSize, right: false),
                    Ball(ballSize: .two, positionX: 0.7 * gameSize.width, gameSize: gameSize)]
        case .five:
            return [Ball(ballSize: .two, positionX: 0.2 * gameSize.width, gameSize: gameSize),
                    Ball(ballSize: .two, positionX: 0.5 * gameSize.width, gameSize: gameSize),
                    Ball(ballSize: .three, positionX: 0.7 * gameSize.width, gameSize: gameSize)]
        case .six:
            return [Ball(ballSize: .four, positionX: 0.5 * gameSize.width, gameSize: gameSize)]
        case .seven:
            return [Ball(ballSize: .four, positionX: 0.2 * gameSize.width, gameSize: gameSize),
                    Ball(ballSize: .two, positionX: 0.8 * gameSize.width, gameSize: gameSize, right: false)]
        case .eight:
            return [Ball(ballSize: .five, positionX: 0.5 * gameSize.width, gameSize: gameSize)]
        case .nine:
            return [Ball(ballSize: .five, positionX: 0.2 * gameSize.width, gameSize: gameSize),
                    Ball(ballSize: .five, positionX: 0.7 * gameSize.width, gameSize: gameSize, right: false)]
            
        }
        
    }
    
    func handleSplit(ballSize: BallSize, ballScore: Int, position: CGPoint, gameSize: CGSize) -> (balls: [Ball], drop: Drop?) {
        
        return (balls: [], drop: nil)
        
    }
    
}
