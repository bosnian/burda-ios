//
//  DashboardViewController.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/7/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import UIKit
import SideMenu

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate, SideMenuDelegate {

    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    var menuAnimator : MenuTransitionAnimator?
    
    @IBOutlet weak var tableView: UITableView!
    
    var models = [SexModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuAnimator = MenuTransitionAnimator(mode: .presentation, shouldPassEventsOutsideMenu: false) { [unowned self] in
            self.dismiss(animated: true, completion: nil)
        }
        
        title = "Ego#"
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 54.0 / 255.0, green: 173.0 / 255.0, blue: 1.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(playGame))
        let listButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(openTrainings))
        navigationItem.rightBarButtonItems?.append(listButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "admin"), style: .plain, target: self, action: #selector(showOptions))
        
        activityView.center = self.view.center
        
        tableView.register(UINib(nibName: "SexTableViewCell", bundle: nil), forCellReuseIdentifier: "SexTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }
    
    @IBAction func addSexPressed(_ sender: Any) {
        let vc = UIStoryboard(name: "AddSex", bundle: nil).instantiateInitialViewController()!
        self.present(vc, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let service = NetworkService()
        service.GetSex(id: Storage.User.id!, success: { (models) in
            self.models = models.reversed()
            self.tableView.reloadData()
        }) {
            self.view.makeToast("Faile to update!")
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SexTableViewCell", for: indexPath) as! SexTableViewCell
        let model = models[indexPath.row]
        
        if let time = model.time, let _ = Double(time) {
            let date = Date(timeIntervalSince1970: Double(time)!)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            cell.time.text = formatter.string(from: Date())
        } else {
            cell.time.text = "-"
        }
        
        if model.userId == Storage.User.id {
            cell.userRating = model.rating ?? 0
            cell.partnerRating = model.partnerRating ?? 0
        } else {
            cell.userRating = model.partnerRating ?? 0
            cell.partnerRating = model.rating ?? 0
        }

        cell.firstRating.layoutSubviews()
        cell.secondRating.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func animationController(forPresented presented: UIViewController, presenting _: UIViewController,
                             source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return menuAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MenuTransitionAnimator(mode: .dismissal)
    }
    
    func openTrainings() {
        let vc = UIStoryboard(name: "Trainings", bundle: nil).instantiateInitialViewController()!
        self.present(vc, animated: true, completion: nil)
    }
    
    func playGame()
    {
        if Storage.Partner.id == nil && Storage.User.rfid != nil {
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
    
    func openProfile() {
        let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController()!
        self.present(vc, animated: true, completion: nil)
    }
    
    func showOptions() {
        
        let vc = UIStoryboard(name: "SideMenu", bundle: nil).instantiateInitialViewController()! as! SideMenuViewController
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    func updateNokia() {
        let vc = UIStoryboard(name: "Nokia", bundle: nil).instantiateInitialViewController()!
        self.present(vc, animated: true, completion: nil)
    }
    
    func logout() {
        let vc = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()!
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
    }
    
    func updatePartner() {
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
