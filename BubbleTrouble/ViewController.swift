//
//  ViewController.swift
//  BubbleTrouble
//
//  Created by Liam Stevenson on 1/28/19.
//  Copyright © 2019 William Stevenson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let gameService = GameService()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gameService.delegate = self
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

extension ViewController: GameServiceDelegate {
    func receivedRotationalDelta(manager: GameService, delta: Double) {
        (UIApplication.shared.delegate! as! AppDelegate).send(message: "\(delta)")
    }
    
    func receivedTap(manager: GameService) {
        (UIApplication.shared.delegate! as! AppDelegate).send(message: "tap")
    }
    
    
    
    
}
