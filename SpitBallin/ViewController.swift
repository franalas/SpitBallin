//
//  ViewController.swift
//  SpitBallin
//
//  Created by Liam Stevenson on 1/29/19.
//  Copyright © 2019 Stevera. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    /// The `SKView` containing the game scene
    @IBOutlet var skView: SKView!
    
    /// The game object which is being presented
    var game: Game!
    
    /// If true, the player is currently moving left
    var movingLeft = false
    
    /// If true, the player is currently moving right
    var movingRight = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        
        game = Game(size: self.skView.bounds.size, person: .liam, firstLevel: LevelNumber.one)
        game.present(inView: self.skView)
        game.paused = false
        
    }
    
    @IBAction
    func beganLeft(_ sender: Any) {
        
        
        
    }
    
    @IBAction
    func beganRight(_ sender: Any) {
        
        
        
    }
    
    @IBAction
    func stoppedLeft(_ sender: Any) {
        
        
        
    }
    
    @IBAction
    func stoppedRight(_ sender: Any) {
        
        
        
    }
    
    @IBAction
    func tap(_ sender: Any) {
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
