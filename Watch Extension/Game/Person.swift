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
    
    func normalImage() -> String {
        
        switch self {
        case .liam:
            return "liam_normal"
        case .fran:
            return "fran_normal"
        }
        
    }
    
    func shootImage() -> String {
        
        switch self {
        case .liam:
            return "liam_shoot"
        case .fran:
            return "fran_shoot"
        }
        
    }
    
}
