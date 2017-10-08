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
    
    var userStarted = false
    var partnerStarted = false
    
    let client = EGymClient()
    
    var tc: TrainingCollector?
    
    var userMachine = ""
    var partnerMachine = ""
    
    var userUpdateLast = 0.0
    var partnerUpdateLast = 0.0
    
    var lastPosition: PositionMachineEvent?
    var partnerLastPosition: PositionMachineEvent?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameScene = GameScene(size: skView.frame.size)
        gameScene?.gameFinishedCallback = gameFinished
        gameScene?.hasPartner = playsWithPartner
        skView.presentScene(gameScene)

        if playsWithPartner {
            startMulti()
        } else {
            startSingle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5.0) {
            self.gameScene?.gameStarted = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+20.0) {
            self.gameScene?.userFinished = true
            self.gameScene?.partnerFinished = true
            self.gameScene?.gameFinished = true
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func gameFinished() {
        gameScene?.gameFinishedCallback = nil
        let service = NetworkService()
        let m = TrainingModel()
        m.userId = Storage.User.id
        m.userId = Storage.Partner.id
        m.machineType = lastPosition?.machine_type
        m.machineType2 = partnerLastPosition?.machine_type
        m.end = lastPosition?.timestamp
        m.result = gameScene?.result
        m.result2 = gameScene?.partnerResult
        Storage.trainings.append(m)
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func startSingle() {
        tc = TrainingCollector(client: client, rfid: Storage.User.rfid!)
        tc?.positionUpdatedCallback = {
            model in

            let position = model.payload!.position!
            self.gameScene!.userPosition = Double(position)
            self.userMachine = model.machine_type!

            self.lastPosition = model
        }
    }

    func startMulti() {
        tc = TrainingCollector(client: client, rfid: nil)
        tc?.positionUpdatedCallback = {
            model in
            let position = model.payload!.position!
            
            if model.rfid == Storage.User.rfid {
                self.gameScene?.userPosition = Double(position)
                self.userMachine = model.machine_type!
                
                self.lastPosition = model
            } else if model.rfid == Storage.Partner.rfid {
                self.gameScene?.partnerPosition = Double(position)
                self.partnerMachine = model.machine_type!
                
                self.partnerLastPosition = model
            }
        }

    }
}
