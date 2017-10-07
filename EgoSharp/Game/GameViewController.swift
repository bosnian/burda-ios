//
//  GameViewController.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/7/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    @IBOutlet weak var skView: SKView!
    
    var gameScene: GameScene?
    
    var playsWithPartner = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameScene = GameScene(size: skView.frame.size)
        skView.presentScene(gameScene)

    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
