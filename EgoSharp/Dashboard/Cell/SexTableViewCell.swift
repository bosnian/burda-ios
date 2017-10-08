//
//  SexTableViewCell.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/8/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import UIKit

class SexTableViewCell: UITableViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var firstRating: UIView!
    @IBOutlet weak var secondRating: UIView!
    
    var userRating = 0
    var partnerRating = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        firstRating.addSubview(RatingView(frame: firstRating.bounds))
        secondRating.addSubview(RatingView(frame: secondRating.bounds))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let f = firstRating.subviews.first! as! RatingView
        f.rating = userRating
        let s = secondRating.subviews.first! as! RatingView
        s.rating = partnerRating
    }
}
