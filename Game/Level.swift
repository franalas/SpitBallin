//
//  Level.swift
//  SpitBallin
//
//  Created by Liam Stevenson on 1/29/19.
//  Copyright © 2019 Stevera. All rights reserved.
//

import Foundation
import SpriteKit

protocol Level {
    
    var nextLevel: Level { get }
    
    func makeLevel(gameSize: CGSize) -> [Ball]
    
}
