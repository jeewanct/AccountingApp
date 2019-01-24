//
//  EditProfileButtonCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 15/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class EditProfileButtonCell: UITableViewCell {
    
    @IBOutlet weak var updateButton: UIButton!
    
    var uploadInfo: EditUpdateEntity?{
        didSet{
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(){
        if let tag = uploadInfo?.tag{
            updateButton.tag = tag
        }
        if uploadInfo?.isAnimating == true{
            updateButton.addButtonIndicator()
        }else{
            updateButton.hideButtonIndicator(title: EditContants.updateProfile.rawValue)
        }
    }
}
