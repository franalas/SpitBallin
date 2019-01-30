//
//  Person.swift
//  Watch Extension
//
//  Created by Liam Stevenson on 1/23/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation

/// Represents the different characters in the game
enum Person {
    
    case liam, fran
    
    /**
     Gets the path to the image of each character normally
     - Returns: The file name, as a String
    */
    func normalImage() -> String {
        
        switch self {
        case .liam:
            return "liam_normal"
        case .fran:
            return "fran_normal"
        }
        
    }
    
    /**
     Gets the path to the image of each character while shooting
     - Returns: The file name, as a String
     */
    func shootImage() -> String {
        
        switch self {
        case .liam:
            return "liam_shoot"
        case .fran:
            return "fran_shoot"
        }
        
    }
    
    /**
     Gets the path to the image of each character while max bullets are shot
     - Returns: The file name, as a String
     */
    func shutImage() -> String {
        
        switch self {
        case .liam:
            return "liam_shut"
        case .fran:
            return "fran_shut"
        }
        
    }
    
    /**
     Gets the path to the image of each character to indicate leftward movement
     - Returns: The file name, as a String
     */
    func leftImage() -> String {
        
        switch self {
        case .liam:
            return "liam_left"
        case .fran:
            return "fran_left"
        }
        
    }
    
    /**
     Gets the path to the image of each character to indicate rightward movement
     - Returns: The file name, as a String
     */
    func rightImage() -> String {
        
        switch self {
        case .liam:
            return "liam_right"
        case .fran:
            return "fran_right"
        }
        
    }
    
}
