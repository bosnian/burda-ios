//
//  LoginMachineEvent.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/7/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import ObjectMapper

class LoginMachineEvent: Mappable {
    var machine_id: String?
    var machine_type: String?
    var timestamp: String?
    var rfid: String?
    var payload: String?
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        machine_id      <- map["machine_id"]
        machine_type    <- map["machine_type"]
        timestamp       <- map["timestamp"]
        rfid            <- map["rfid"]
    }
}
