//
//  UserModel.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/7/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import Foundation
import ObjectMapper

class UserModel : Mappable {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var email: String?
    var age: String?
    var rfid: String?
    var partnerId: Int?
    var partnerRfid: String?
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id           <- map["id"]
        firstName    <- map["first_name"]
        lastName     <- map["last_name"]
        email        <- map["email"]
        age          <- map["age"]
        rfid         <- map["rfid"]
        partnerId    <- map["partner_id"]
//        partnerRfid  <- map["partner_rfid"]
    }
}

