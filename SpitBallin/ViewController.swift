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

    /// The `GameView` containing the game scene
    @IBOutlet var gameView: GameView!
    
    /// The button for rightward movement
    @IBOutlet weak var rightButton: UIButton!
    
    /// The button for leftward movement
    @IBOutlet weak var leftButton: UIButton!
    
    /// The game object which is being presented
    var game: Game!
    
    var character = Person.liam {
        didSet {
            game.character = character
            rightButton.setImage(UIImage(named: character.rightImage()), for: .normal)
            leftButton.setImage(UIImage(named: character.leftImage()), for: .normal)
        }
    }
    
    /// If true, the player is currently moving left
    var movingLeft = false {
        didSet { game.movingLeft = movingLeft }
    }
    
    /// If true, the player is currently moving right
    var movingRight = false {
        didSet { game.movingRight = movingRight }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        rightButton.setImage(UIImage(named: character.rightImage()), for: .normal)
        leftButton.setImage(UIImage(named: character.leftImage()), for: .normal)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        
        if game == nil {
            game = Game(size: self.gameView.bounds.size, person: .liam, firstLevel: LevelNumber.one)
            game.present(inView: self.gameView)
            game.paused = false
            gameView.game = game
        }
        
    }
    
    @IBAction
    func beganLeft(_ sender: Any) {
        
        movingLeft = true
        
    }
    
    @IBAction
    func beganRight(_ sender: Any) {
        
        movingRight = true
        
    }
    
    @IBAction
    func stoppedLeft(_ sender: Any) {
        
        movingLeft = false
        
    }
    
    @IBAction
    func stoppedRight(_ sender: Any) {
        
        movingRight = false
        
    }
    
    @IBAction
    func tap(_ sender: Any) {
        
        game.shoot()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
