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
    
    var sprite: SKNode
    var radius: CGFloat
    var position: CGPoint { return CGPoint.zero }
    
    /// The x-position of `self` in the scene
    var xPosition: CGFloat {
        get { return 0 }
        set { }
    }
    
    /// The character used for `self`
    var character: Person {
        didSet { }
    }
    
    /**
     Initializes a `Player` object with a given character and screen bounds
     - Parameters:
        - person: The character that the player should be
        - frame: The bounds of the screen
    */
    init(person: Person, frame: CGRect) { self.character = person; self.sprite = SKNode(); self.radius = 0 }
    
}
