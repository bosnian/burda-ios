//
//  NetworkService.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/7/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import Foundation
import Alamofire


class NetworkService {
    var url = "http://egosharp.herokuapp.com"
    
    init() {
        
    }
    
    
    func RequestLogin(email: String, password: String, success: @escaping (UserModel)->(), fail: @escaping ()->()) {
        var parameters = Parameters()
        parameters["email"] = email
        parameters["password"] = password
        
        Alamofire.request(url + "/login", method: .post, parameters: parameters).responseObject {
            (response: DataResponse<UserModel>) in
            
            if response.result.isSuccess {
                success(response.result.value!)
            } else {
                fail()
            }
        }
    }
    
    func UpdatePartner(id: Int, partnerId: Int, success: @escaping (UserModel)->(), fail: @escaping ()->()) {
        var parameters = Parameters()
        parameters["id"] = id
        parameters["partner_id"] = partnerId
        
        if id == partnerId {
            fail()
            return
        }
        
        Alamofire.request(url + "/update_partner", method: .post, parameters: parameters).responseObject {
            (response: DataResponse<UserModel>) in
            
            if response.result.isSuccess {
                success(response.result.value!)
            } else {
                fail()
            }
        }
    }
}
