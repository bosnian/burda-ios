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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(playGame))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "admin"), style: .plain, target: self, action: #selector(showOptions))
        
        activityView.center = self.view.center
    }
    
    func playGame()
    {
        
        if Storage.User.partnerRfid == nil{
            let vc = UIStoryboard(name: "Game", bundle: nil).instantiateInitialViewController()!
            self.present(vc, animated: true, completion: nil)
        } else {
            
            let alert = UIAlertController(title: "Multiplayer", message: "Do you want to play with partner?", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default){
                action in
                
                let vc = UIStoryboard(name: "Game", bundle: nil).instantiateInitialViewController()! as! GameViewController
                vc.playsWithPartner = true
                self.present(vc, animated: true, completion: nil)
                
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
            
        }
        actionSheetController.addAction(nokiaAction)
        
        let userData = UIAlertAction(title: "My Data", style: .default)
        { _ in
            
        }
        actionSheetController.addAction(userData)
        
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
            }
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func successPartner(model: UserModel) {
        self.activityView.stopAnimating()
        Storage.Partner = model
        view.makeToast("Partner updated!")
    }
    
    func failPartner() {
        self.activityView.stopAnimating()
        view.makeToast("Updating user failed. Please check ID!")
    }
}
