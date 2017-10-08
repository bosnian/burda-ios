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
    
    func RequestPartner(id: Int, success: @escaping (UserModel)->(), fail: @escaping ()->()) {
        
        Alamofire.request(url + "/users/\(id)").responseObject {
            (response: DataResponse<UserModel>) in
            
            if response.result.isSuccess {
                success(response.result.value!)
            } else {
                fail()
            }
        }
    }
    
    func UpdateRfid(id: Int, rfid: String, success: @escaping (UserModel)->(), fail: @escaping ()->()) {
        var parameters = Parameters()
        parameters["rfid"] = rfid
  
        Alamofire.request(url + "/users/\(id)", method: .put, parameters: parameters).responseObject {
            (response: DataResponse<UserModel>) in
            
            if response.result.isSuccess {
                success(response.result.value!)
            } else {
                fail()
            }
        }
    }
    
    func UpdateNokiaCode(id: Int, code: String, success: @escaping (UserModel)->(), fail: @escaping ()->()) {
        var parameters = Parameters()
        parameters["code"] = code
        
        Alamofire.request(url + "/users/\(id)", method: .put, parameters: parameters).responseObject {
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
        parameters["partner_id"] = partnerId
        
        if id == partnerId {
            fail()
            return
        }
        
        Alamofire.request(url + "/users/\(id)", method: .post, parameters: parameters).responseObject {
            (response: DataResponse<UserModel>) in
            
            if response.result.isSuccess {
                success(response.result.value!)
            } else {
                fail()
            }
        }
    }
    
    func AddTrainig(id: Int, machineType: String, partnerId: Int?, startTime: String, endTime: String, result: Int ,success: @escaping (TrainingModel)->(), fail: @escaping ()->()) {
        
        var parameters = Parameters()
        
        parameters["user_id"] = id
        parameters["partner_id"] = partnerId
        parameters["start_time"] = startTime
        parameters["end_time"] = endTime
        parameters["result"] = result
        parameters["machine_type"] = machineType

        Alamofire.request(url + "/trainings/new", method: .post, parameters: parameters).responseObject {
            (response: DataResponse<TrainingModel>) in
            
            if response.result.isSuccess {
                success(response.result.value!)
            } else {
                fail()
            }
        }
    }
    
    func GetTrainigs(id: Int, success: @escaping ([TrainingModel])->(), fail: @escaping ()->()) {

        Alamofire.request(url + "/trainings?user_id=\(id)", method: .get).responseArray {
            (response: DataResponse<[TrainingModel]>) in
            
            if response.result.isSuccess {
                success(response.result.value!)
            } else {
                fail()
            }
        }
    }
}
