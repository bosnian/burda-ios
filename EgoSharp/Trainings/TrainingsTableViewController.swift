//
//  TrainingsTableViewController.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/8/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import UIKit

class TrainingsTableViewController: UITableViewController {

    
    var trainings = [TrainingModel]()
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 54.0 / 255.0, green: 173.0 / 255.0, blue: 1.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
        tableView.register(UINib(nibName: "TrainigTableViewCell", bundle: nil), forCellReuseIdentifier: "TrainigTableViewCell")
    }
    
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let service = NetworkService()
        service.GetTrainigs(id: Storage.User.id!, success: success, fail: fail)
        view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func success(models: [TrainingModel]) {
        activityView.stopAnimating()
        activityView.removeFromSuperview()
        trainings = models
        tableView.reloadData()
    }
    
    func fail(){
        activityView.stopAnimating()
        activityView.removeFromSuperview()
        view.makeToast("Failed to fetch trainings!")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return trainings.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainigTableViewCell", for: indexPath) as! TrainigTableViewCell
        let model = trainings[indexPath.row]
        
        cell.timeLabel.text = model.end ?? "-"
        cell.resultLabel.text = "\(model.result ?? 0)"
        cell.machineLabel.text = model.machineType
        
        cell.partnerResultLabel.text = "-"
        cell.partnerMachineLabel.text = "-"
        return cell
    }
}
