//
//  AddSexViewController.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/8/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import UIKit

class AddSexViewController: UIViewController {

    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var closeImageView: UIImageView!
    
    @IBOutlet weak var ratingView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeImageView.image = closeImageView.image?.maskWithColor(color: UIColor(red: 54.0 / 255.0, green: 173.0 / 255.0, blue: 1.0, alpha: 1.0))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        closeView.addGestureRecognizer(tap)
        let r = RatingView(frame: ratingView.bounds)
        r.editable = true
        r.callback = {
            let service = NetworkService()
            service.AddSex(id: Storage.User.id!, rating: r.rating, success: { (model) in
                self.dismiss(animated: true, completion: nil)
            }, fail: {
                self.view.makeToast("Failed to add!")
                self.dismiss(animated: true, completion: nil)
            })
        }
        ratingView.addSubview(r)
    }

    func handleTap(){
        dismiss(animated: true, completion: nil)
    }
}
