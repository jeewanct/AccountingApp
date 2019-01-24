//
//  EditProfileImageCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 15/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class EditProfileImageCell: UITableViewCell{
    
    @IBOutlet weak var profileImageButton: UIButton!
    var imageName: String?{
        didSet{
            profileImageButton.addImage(url: imageName)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        profileImageButton.layer.cornerRadius = profileImageButton.frame.height / 2
        
        
    }
    
}
