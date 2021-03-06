//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by Liam Stevenson on 1/23/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import WatchKit
import Foundation
import SpriteKit

class InterfaceController: WKInterfaceController {
    
    /// How much the digital crown rotational delta is multiplier by to determine amount of player movement
    static let CROWN_MULTIPLIER: CGFloat = 0.5

    @IBOutlet var skInterface: WKInterfaceSKScene!
    var game: Game!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        crownSequencer.delegate = self
        
        self.game = Game(size: WKInterfaceDevice.current().screenBounds.size, person: .liam, firstLevel: LevelNumber.one)
        self.game.present(inInterface: self.skInterface)
        self.game.paused = false
        
    }
    
    override func didAppear() {
        
        super.didAppear()
        crownSequencer.focus()
        self.game.paused = false
        
    }
    
    override func willDisappear() {
        
        self.game.paused = true
        
    }

    @IBAction func tapAction(_ sender: Any) {
        
        self.game.shoot()
        
    }
    
    @IBAction func playAction() {
        
        self.game.paused = false
        
    }
    
    @IBAction func pauseAction() {
        
        self.game.paused = true
        
    }
    
    @IBAction func restartAction() {
        
        self.game.restart()
        
    }
    
    @IBAction func switchAction() {
        
        if let game = self.game {
            switch game.character {
            case .liam:
                game.character = .fran
            case .fran:
                game.character = .liam
            }
        }
        
    }
    
}

extension InterfaceController: WKCrownDelegate {
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        
        game.movePlayer(distance: CGFloat(rotationalDelta) * InterfaceController.CROWN_MULTIPLIER * WKInterfaceDevice.current().screenBounds.width)
        
    }
    
}
