//
//  SexModel.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/8/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import ObjectMapper

class SexModel : Mappable {
    var id: Int?
    var userId: Int?
    var partnerId: Int?
    var time: String?
    var rating: Int?
    var partnerRating: Int?
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id           <- map["id"]
        userId       <- map["partner_one_id"]
        partnerId    <- map["partner_two_id"]
        time         <- map["start_time"]
        rating       <- map["partner_one_res"]
        partnerRating <- map["partner_two_res"]
    }
    
}
