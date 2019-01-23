//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by Liam Stevenson on 1/23/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var skInterface: WKInterfaceSKScene!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        crownSequencer.delegate = self
        
        // Configure interface objects here.
        
        // Create the SKScene
        let scene = GameScene()
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        // Present the scene
        self.skInterface.presentScene(scene)
        
        // Use a value that will maintain a consistent frame rate
        self.skInterface.preferredFramesPerSecond = 30
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        crownSequencer.focus()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func tapAction(_ sender: Any) {
        
        //tap occured
        
    }
    
}

extension InterfaceController: WKCrownDelegate {
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        
        //scroll occurred
        
    }
    
}
