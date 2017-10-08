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
//    var url = "http://egosharp.herokuapp.com"
    var url = "http://10.50.155.27:3000"
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
        
        Alamofire.request(url + "/users/\(id)", method: .put, parameters: parameters).responseObject {
            (response: DataResponse<UserModel>) in
            
            if response.result.isSuccess {
                success(response.result.value!)
            } else {
                fail()
            }
        }
    }
    
    func AddTrainig(id: Int, machineType: String, machineType2: String, partnerId: Int?, startTime: String, endTime: String, result: Int, result2: Int  ,success: @escaping (TrainingModel)->(), fail: @escaping ()->()) {
        
        var parameters = Parameters()
        
        parameters["user_id"] = id
        parameters["partner_id"] = partnerId
        parameters["start_time"] = startTime
        parameters["end_time"] = endTime
        parameters["result"] = result
        parameters["result2"] = result2
        parameters["machine_type"] = machineType
        parameters["machine_type2"] = machineType2

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
    
    func GetSex(id: Int, success: @escaping ([SexModel])->(), fail: @escaping ()->()) {
        
        Alamofire.request(url + "/sexes?user_id=\(id)", method: .get).responseArray {
            (response: DataResponse<[SexModel]>) in
            
            if response.result.isSuccess {
                success(response.result.value!)
            } else {
                fail()
            }
        }
    }
    
    func AddSex(id: Int, rating: Int, success: @escaping (SexModel)->(), fail: @escaping ()->()) {
        var parameters = Parameters()
        parameters["user_id"] = id
        parameters["partner_id"] = Storage.User.partnerId
        parameters["partner_one_res"] = rating
        parameters["start_time"] = "\(Date().timeIntervalSince1970)"
        
        Alamofire.request(url + "/sexes", method: .post, parameters: parameters).responseObject {
            (response: DataResponse<SexModel>) in
            
            if response.result.isSuccess {
                success(response.result.value!)
            } else {
                fail()
            }
        }
    }
    
    func RateSex(sexId: Int, rating: Int, success: @escaping (SexModel)->(), fail: @escaping ()->()) {
        var parameters = Parameters()
        parameters["partner_two_res"] = rating
        
        Alamofire.request(url + "/sex/\(rating)", method: .post, parameters: parameters).responseObject {
            (response: DataResponse<SexModel>) in
            
            if response.result.isSuccess {
                success(response.result.value!)
            } else {
                fail()
            }
        }
    }
}
