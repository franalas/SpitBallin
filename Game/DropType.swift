//
//  DropType.swift
//  SpitBallin
//
//  Created by Liam Stevenson on 1/30/19.
//  Copyright © 2019 Stevera. All rights reserved.
//

import Foundation

enum DropType {
    
    /// Gives the player another life
    case life
    
    /// Lets the player shoot one more shot at a time
    case shot
    
    /// Puts a machine gun on the ground that sprays a quick burst of shots
    case machineGun
    
    /// Gives the player a shield that lasts one hit
    case shield
    
    /// Gets name of the image for the drop
    ///
    /// - Returns: The name of the image
    func getImage() -> String {
        
        switch self {
        case .life:
            return "water_bottle"
        case .shot:
            return "spit"
        case .machineGun:
            return "sports_bottle"
        case .shield:
            return "gum"
        }
        
    }
    
    /// Perform's the action corresponding to the drop
    ///
    /// - Parameter game: The game that the action is to be performed in
    func performAction(inGame game: Game) {
        
        switch self {
        case .life:
            game.addLife()
        case .shot:
            game.addShot()
        case .machineGun:
            break
        case .shield:
            game.giveShield()
        }
        
    }
    
}
