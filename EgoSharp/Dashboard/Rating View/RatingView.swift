//
//  RatingView.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/8/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import UIKit

class RatingView: UIView {
    
    let max = 5
    
    var stars = [UIImageView]()

    var rating = 0
    
    var editable = false
    
    var callback: EmptyCallback?
    
    override func layoutSubviews() {
        
        if stars.count == 0 {
            for _ in 0...max-1 {
                let v = UIImageView(frame: CGRect())
                v.image = UIImage(named: "star")
                stars.append(v)
                addSubview(v)
                
                if editable {
                    let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
                    v.isUserInteractionEnabled = true
                    v.addGestureRecognizer(tap)
                }
            }
        }
        
        let width = bounds.width / 5
        for (i,star) in stars.enumerated() {
            star.frame = CGRect(x: CGFloat(i)*width, y: 0, width: width, height: width)
            if i < rating {
                star.image = UIImage(named: "star-full")?.maskWithColor(color: UIColor(red: 54.0 / 255.0, green: 173.0 / 255.0, blue: 1.0, alpha: 1.0))
            } else {
                star.image = UIImage(named: "star")?.maskWithColor(color: UIColor(red: 54.0 / 255.0, green: 173.0 / 255.0, blue: 1.0, alpha: 1.0))
            }
        }        
        super.layoutSubviews()
    }
    
    func handleTap(gest: UIGestureRecognizer) {
        if editable {
            for i in 0...4 {
                if stars[i] == (gest.view! as! UIImageView) {
                    rating = i + 1
                    layoutSubviews()
                    editable = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.4) {
                        self.callback?()
                    }
                }
            }
        }
    }
}
