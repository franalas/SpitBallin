//
//  Ball.swift
//  Watch Extension
//
//  Created by Francisco Turdera on 1/23/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import Foundation
import SpriteKit

class Ball: SKShapeNode {
    
    /// Represents size of self
    private var ballSize: BallSize?
    
    /// Represents color of self
    private var color: UIColor?
    
    convenience init(ballSize: BallSize, color: UIColor, position: CGPoint, velocity: CGVector) {
       
        self.init(circleOfRadius: 0)
        self.ballSize = ballSize
        self.color = color
        
    }
    
    override private init() {
        
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
