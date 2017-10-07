//
//  ViewController.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/7/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import UIKit
import SpriteKit
import SwiftyZeroMQ

class ViewController: UIViewController {

    
    @IBOutlet weak var gameView: SKView!
    let client = EGymClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.frame.size)
        gameView.presentScene(scene)
        
        
        let tc = TrainingCollector(client: client,rfid: "bdfc1cee")

        tc.positionUpdatedCallback = {
            model in
            let position = model.payload!.position!
            scene.userPosition = Double(position)
        }

        DispatchQueue.global(qos: .background).async {
            do {
                try self.client.connect()
            } catch {
                print("Something went wrong")
                print(error)
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

