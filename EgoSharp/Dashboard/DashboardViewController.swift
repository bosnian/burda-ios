//
//  DashboardViewController.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/7/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ego#"
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 54.0 / 255.0, green: 173.0 / 255.0, blue: 1.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(playGame))
        let listButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(openTrainings))
        navigationItem.rightBarButtonItems?.append(listButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "admin"), style: .plain, target: self, action: #selector(showOptions))
        
        activityView.center = self.view.center
    }
    
    func openTrainings() {
        let vc = UIStoryboard(name: "Trainings", bundle: nil).instantiateInitialViewController()!
        self.present(vc, animated: true, completion: nil)
    }
    
    func playGame()
    {
        if Storage.Partner.id == nil{
            let vc = UIStoryboard(name: "Game", bundle: nil).instantiateInitialViewController()!
            self.present(vc, animated: true, completion: nil)
        } else if Storage.User.rfid == nil {
            view.makeToast("You need to register bracelet!")
        } else {
            
            let alert = UIAlertController(title: "Multiplayer", message: "Do you want to play with partner?", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default){
                action in
                
                if Storage.Partner.rfid == nil {
                    self.view.makeToast(Storage.Partner.firstName! + " needs to register bracelet!")
                } else {
                    let vc = UIStoryboard(name: "Game", bundle: nil).instantiateInitialViewController()! as! GameViewController
                    vc.playsWithPartner = true
                    self.present(vc, animated: true, completion: nil)
                }
                
            })
            
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default){
                action in
                
                let vc = UIStoryboard(name: "Game", bundle: nil).instantiateInitialViewController()!
                self.present(vc, animated: true, completion: nil)
            })
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showOptions() {
        let actionSheetController: UIAlertController = UIAlertController(title: "Settings", message: "Please select option", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
  
        }
        actionSheetController.addAction(cancelActionButton)
        
        let partnerAction = UIAlertAction(title: "Partner", style: .default)
        { _ in
            self.addPartner()
        }
        actionSheetController.addAction(partnerAction)
        
        let nokiaAction = UIAlertAction(title: "Nokia Health", style: .default)
        { _ in
            let vc = UIStoryboard(name: "Nokia", bundle: nil).instantiateInitialViewController()!
            self.present(vc, animated: true, completion: nil)
        }
        actionSheetController.addAction(nokiaAction)
        
        let braceletAction = UIAlertAction(title: "Bracelet", style: .default)
        { _ in
            self.updateBracelet()
        }
        actionSheetController.addAction(braceletAction)
        
        let userData = UIAlertAction(title: "My Data", style: .default)
        { _ in
            
        }
        actionSheetController.addAction(userData)
        
        let logoutData = UIAlertAction(title: "Log Out", style: .default)
        { _ in
            let vc = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()!
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = vc
        }
        actionSheetController.addAction(logoutData)
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func addPartner() {
        let alert = UIAlertController(title: "Update Partner", message: "Please enter partner ID", preferredStyle: .alert)
        
        
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { [weak alert] (_) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0]
            
    
            self.activityView.startAnimating()
            self.view.addSubview(self.activityView)
            
            let service = NetworkService()
            if let partnerId = Int(textField.text!) {
                service.UpdatePartner(id: Storage.User.id!, partnerId: partnerId, success: self.successPartner, fail: self.failPartner)
                self.showLoader()
            }
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func successPartner(model: UserModel) {
        self.activityView.stopAnimating()
        Storage.Partner = model
        stopLoader()
        view.makeToast("Partner updated!")
    }
    
    func failPartner() {
        stopLoader()
        view.makeToast("Updating user failed. Please check ID!")
    }
    
    
    func updateBracelet() {
        let alert = UIAlertController(title: "Update Bracelet", message: "Please enter bracelet RFID", preferredStyle: .alert)
        
        
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { [weak alert] (_) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0]
            
            
            self.activityView.startAnimating()
            self.view.addSubview(self.activityView)
            
            let service = NetworkService()
            if textField.text?.characters.count == 8 {
                service.UpdateRfid(id: Storage.User.id!, rfid: textField.text!, success: self.successBracelet, fail: self.failBracelet)
                self.showLoader()
                
            } else {
                self.view.makeToast("Invalid RFID")
            }
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func successBracelet(model: UserModel) {
        stopLoader()
        Storage.User = model
        view.makeToast("RFID updated!")
    }
    
    func failBracelet() {
        stopLoader()
        view.makeToast("Failed to update RFID")
    }
    
    func showLoader() {
        activityView.startAnimating()
        view.addSubview(activityView)
    }
    
    func stopLoader(){
        activityView.removeFromSuperview()
    }
}
