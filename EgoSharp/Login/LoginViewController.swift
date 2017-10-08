//
//  LoginViewController.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/7/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var fieldContainerView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: emailField.frame.size.height - width, width:  emailField.frame.size.width, height: emailField.frame.size.height)
        
        border.borderWidth = width
        emailField.layer.addSublayer(border)
        emailField.layer.masksToBounds = true
        
        fieldContainerView.layer.cornerRadius = 10.0
        fieldContainerView.clipsToBounds = true
        
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
        
        registerButton.layer.cornerRadius = 10
        registerButton.clipsToBounds = true
        
        emailField.text = "michael@gmail.com"
        passwordField.text = "michael"
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        let service = NetworkService()
        service.RequestLogin(email: emailField.text!, password: passwordField.text!, success: success, fail: fail)
    }
    
    func success(model: UserModel) {
        
        Storage.User = model
        
        if let id = model.partnerId {
            let service = NetworkService()
            service.RequestPartner(id: id, success: successPartner, fail: fail)
        } else {
            openDashboard()
        }
    }
    
    func successPartner(model: UserModel) {
        Storage.Partner = model
        openDashboard()
    }
    
    func openDashboard() {
        let vc = UIStoryboard(name: "Dashboard", bundle: nil).instantiateInitialViewController()!
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
    }
    
    func fail() {
        view.makeToast("Please check your credentials!")
    }
}
