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

        gameFinished()
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func gameFinished() {
        let service = NetworkService()
        service.AddTrainig(id: Storage.User.id!, machineType: "M9", partnerId: playsWithPartner ? Storage.User.partnerId : nil, startTime: tc?.data?.start ?? "", endTime: tc?.data?.end ?? "", result: gameScene?.result ?? 0, success: { (model) in
            self.dismiss(animated: true, completion: nil)
        }) {
            self.view.makeToast("Failed to add trainig!")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func startSingle() {
        tc = TrainingCollector(client: client, rfid: Storage.User.rfid!)
        
        tc?.startCallback = {
            model in
            
            self.gameScene?.gameStarted = true
            
        }
        
        tc?.positionUpdatedCallback = {
            model in
            let position = model.payload!.position!
            self.gameScene!.userPosition = Double(position)
        }
        
        tc?.finishCallback = {
            model in
            
            if model.rfid == Storage.User.rfid {
                self.gameScene?.userFinished = true
                self.gameScene?.gameFinished = true
            }
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
    
    func startMulti() {
        tc? = TrainingCollector(client: client, rfid: nil)
        
        tc?.startCallback = {
            model in
            
            
            if model.rfid == Storage.User.rfid {
                self.userStarted = true
            } else if model.rfid == Storage.Partner.rfid {
                self.partnerStarted = true
            }
            
            if self.userStarted && self.partnerStarted {
                self.gameScene?.gameStarted = true
            }
        }
        
        tc?.positionUpdatedCallback = {
            model in
            let position = model.payload!.position!
            
            if model.rfid == Storage.User.rfid {
                self.gameScene?.userPosition = Double(position)
            } else if model.rfid == Storage.Partner.rfid {
                self.gameScene?.partnerPosition = Double(position)
            }
        }
        
        tc?.finishCallback = {
            model in
            
            if model.rfid == Storage.User.rfid {
                self.gameScene?.userFinished = true
            } else if model.rfid == Storage.Partner.rfid {
                self.gameScene?.partnerFinished = true
            }
            
            if self.gameScene!.userFinished && self.gameScene!.partnerFinished {
                self.gameScene!.gameFinished = true
            }
            
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
}
