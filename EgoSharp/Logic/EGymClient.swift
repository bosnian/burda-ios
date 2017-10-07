//
//  EGymClient.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/7/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import SwiftyZeroMQ
import ObjectMapper

typealias LoginEventCallback = (LoginMachineEvent)->()
typealias PositionEventCallback = (PositionMachineEvent)->()
typealias LogoutEventCallback = (LogoutMachineEvent)->()

class EGymClient {
    
    let ENDPOINT = "tcp://35.195.199.160:5556"
    
    var startedTraining: LoginEventCallback?
    var position: PositionEventCallback?
    var ended: LogoutEventCallback?
    
    var context: SwiftyZeroMQ.Context?
    
    func connect() throws {
        context      = try SwiftyZeroMQ.Context()
        let subscriber  = try context!.socket(.subscribe)
        
        try subscriber.connect(ENDPOINT)
        try subscriber.setSubscribe(nil)
        
        
        let poller = SwiftyZeroMQ.Poller()
        try poller.register(socket: subscriber, flags: .pollIn)
        
        func pollAndRecv() throws {
            let socks = try poller.poll(timeout: 1000)
            for subscriber in socks.keys {
                let name = "Demo"
                if socks[subscriber] == SwiftyZeroMQ.PollFlags.pollIn {
                    let text = try subscriber.recv(options: .dontWait)
//                    print("\(name): received '\(text)'")
                    if let text = text {
                        DispatchQueue.main.async {
                            self.parseData(data: text)
                        }
                        
                    }
                } else {
//                    print("\(name): Nothing")
                }
            }
            print("---")
            
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now()) {
                do {
                    try pollAndRecv()
                } catch {
                    print(error)
                }
            }
        }
        
        try pollAndRecv()
    }
    
    func parseData(data: String) {
        if data.starts(with: "login") {
            let parsed = data.replacingOccurrences(of: "login ", with: "")
            let model = Mapper<LoginMachineEvent>().map(JSONString: parsed)!
            startedTraining?(model)
        } else if data.starts(with: "training_position_data")  {
            let parsed = data.replacingOccurrences(of: "training_position_data ", with: "")
            let model = Mapper<PositionMachineEvent>().map(JSONString: parsed)!
            position?(model)
        } else if data.starts(with: "logout ") {
            let parsed = data.replacingOccurrences(of: "logout ", with: "")
            let model = Mapper<LogoutMachineEvent>().map(JSONString: parsed)!
            ended?(model)
        }
    }
}