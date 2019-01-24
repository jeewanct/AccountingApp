//
//  ProfileImageCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 17/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class ProfileImageCell: UITableViewCell{
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var borderView: UIView!
    var imageName: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.addImage(url: imageName)
        
        borderView.layer.cornerRadius = borderView.frame.height / 2
        
    }
    
}
