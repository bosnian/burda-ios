//
//  SideMenuViewController.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/8/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import UIKit
import SideMenu

protocol SideMenuDelegate {
    func openProfile()
    func updatePartner()
    func updateNokia()
    func updateBracelet()
    func logout()
}

class SideMenuViewController: UIViewController, Menu {
    
    var menuItems = [UIView] ()
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thridView: UIView!
    @IBOutlet weak var fourthView: UIView!
    @IBOutlet weak var fifthView: UIView!
    
    var delegate: SideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuItems.append(firstView)
        menuItems.append(secondView)
        menuItems.append(thridView)
        menuItems.append(fourthView)
        menuItems.append(fifthView)
        
        for v in menuItems {
            if let iv = v.subviews.first as? UIImageView {
                iv.image = iv.image?.maskWithColor(color: .white)
            }
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(gest:)))
            v.addGestureRecognizer(tap)
        }
        
        view.backgroundColor = .clear
        preferredContentSize = CGSize(width: 100, height: view.frame.height)
    }
    
    func handleTap(gest: UIGestureRecognizer) {
        let v = gest.view!
        
        dismiss(animated: true) {
            if v === self.firstView {
                self.delegate?.openProfile()
            } else if v === self.secondView {
                self.delegate?.updateBracelet()
            } else if v === self.thridView {
                self.delegate?.updateNokia()
            } else if v === self.fourthView {
                self.delegate?.updatePartner()
            } else if v === self.fifthView {
                self.delegate?.logout()
            }
        }
    }
}
