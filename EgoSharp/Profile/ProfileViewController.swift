//
//  ProfileViewController.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/8/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var closeImageView: UIImageView!
    @IBOutlet weak var content: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        closeImageView.image = closeImageView.image?.maskWithColor(color: UIColor(red: 54.0 / 255.0, green: 173.0 / 255.0, blue: 1.0, alpha: 1.0))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        closeView.addGestureRecognizer(tap)
        
        var text = "ID \(Storage.User.id!)\n\(Storage.User.firstName!) \(Storage.User.lastName!)\n\(Storage.User.email!)\n"
        
        if let rfid = Storage.User.rfid {
            text += "RFID \(rfid)\n"
        }
        
        if let name = Storage.Partner.firstName {
            text += "\n\nPartner\n \(name) \(Storage.Partner.lastName!)\n"
        }
        
        content.text = text
    }
    
    func handleTap(){
        dismiss(animated: true, completion: nil)
    }
}
