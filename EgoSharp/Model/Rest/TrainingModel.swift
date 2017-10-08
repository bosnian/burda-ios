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
    var machineType2: String?
    var start: String?
    var end: String?
    var result: Int?
    var result2: Int?
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id           <- map["id"]
        userId       <- map["user_id"]
        partnerId    <- map["partner_id"]
        machineType  <- map["machine_type"]
        machineType2  <- map["machine_type2"]
        start        <- map["start"]
        end          <- map["end"]
        result       <- map["result"]
        result2       <- map["result2"]
    }
}
