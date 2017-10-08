//
//  TrainingModel.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/8/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import ObjectMapper

class TrainingModel : Mappable {
    var id: Int?
    var userId: Int?
    var partnerId: Int?
    var machineType: String?
    var start: String?
    var end: String?
    var result: Int?
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id           <- map["id"]
        userId       <- map["user_id"]
        partnerId    <- map["partner_id"]
        machineType  <- map["machine_type"]
        start        <- map["start"]
        end          <- map["end"]
        result       <- map["result"]
    }
}
