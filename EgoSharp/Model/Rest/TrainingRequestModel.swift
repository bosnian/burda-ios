//
//  TrainingRequestModel.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/7/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import ObjectMapper

class TrainingRequestModel: Mappable {
    var rfid: String?
    var machine_type: String?
    var start: String?
    var end: String?
    var time: String?
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        rfid            <- map["rfid"]
        machine_type    <- map["machine_type"]
        start           <- map["start"]
        end             <- map["end"]
        time            <- map["time"]
    }
}

