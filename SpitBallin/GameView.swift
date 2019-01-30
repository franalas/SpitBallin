//
//  GameView.swift
//  SpitBallin
//
//  Created by Liam Stevenson on 1/29/19.
//  Copyright © 2019 Stevera. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class GameView: SKView {
    
    var game: Game!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        game.shoot()
        
    }
    
}
