//
//  TrainingCollector.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/7/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import Foundation

class TrainingCollector {
    
    private let client: EGymClient
    
    var data: TrainingRequestModel?
    var rfid: String?
    
    var position = 0.0
    
    var positionUpdatedCallback: PositionEventCallback?
    
    init(client: EGymClient, rfid: String?) {
        self.client = client
        self.rfid = rfid
        
        client.startedTraining = startedTraining
        client.position = positionUpdated
        client.ended = endedTraining
    }
    
    func startedTraining(model: LoginMachineEvent) {

        
        if rfid == nil || model.rfid == rfid {
     
            data = TrainingRequestModel()
            data?.rfid = model.rfid
            data?.start = model.timestamp
            data?.machine_type = model.machine_type
            
            print("######## START")
            print("#######")
        }
    }
    
    func positionUpdated(model: PositionMachineEvent) {
        if rfid == model.rfid {
            if let position = model.payload?.position {
                self.position = Double(position)
                positionUpdatedCallback?(model)
                print("######## POSITION")
                print("#######")
            }
        }
    }
    
    func endedTraining(model: LogoutMachineEvent) {
        
        if data != nil && rfid == model.rfid {
            print("######## END")
            print("#######")
            data!.end = model.timestamp
        }
    }
}
