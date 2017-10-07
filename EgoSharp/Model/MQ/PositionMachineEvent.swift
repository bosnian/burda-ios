//
//  PositionMachineEvent.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/7/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import ObjectMapper

class PositionMachineEvent: Mappable {
    var machine_id: String?
    var machine_type: String?
    var timestamp: String?
    var rfid: String?
    var payload: PositionMachineEventPayload?
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        machine_id      <- map["machine_id"]
        machine_type    <- map["machine_type"]
        timestamp       <- map["timestamp"]
        rfid            <- map["rfid"]
        payload         <- map["payload"]
    }
    
}

class PositionMachineEventPayload: Mappable {
    
    var position: Float?
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        position      <- map["position"]
    }
}

