//
//  DropType.swift
//  SpitBallin
//
//  Created by Liam Stevenson on 1/30/19.
//  Copyright © 2019 Stevera. All rights reserved.
//

import Foundation
import SpriteKit

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
    
    /// Perform's the action corresponding to the drop hitting the floor
    ///
    /// - Parameter game: The game that the action is to be performed in
    /// - Returns: `true` iff the drop should be removed from the game
    func performFloorAction(inGame game: Game, drop: Drop) -> Bool {
        
        drop.velocity = CGVector.zero
        drop.acceleration = CGVector.zero
        switch self {
        case .machineGun:
            break
        default:
            return false
        }
        
        return true
        
    }
    
    
    /// Perform's the action corresponding to the drop being picked up by the player
    ///
    /// - Parameter game: The game that the action is to be performed in
    /// - Returns: `true` iff the drop should be removed from the game
    func performPickupAction(inGame game: Game, drop: Drop) -> Bool {
        
        switch self {
        case .life:
            game.addLife()
        case .shot:
            game.addShot()
        case .shield:
            game.giveShield()
        default:
            return false
        }
        
        return true
        
    }
    
}
