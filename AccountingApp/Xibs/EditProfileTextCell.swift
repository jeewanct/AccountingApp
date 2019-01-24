//
//  EditProfileTextCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 15/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class EditProfileTextCell: UITableViewCell{
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var optionImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup(){
        
        textField.leftMargins()
        
    }
    
    var editInfo: EditUserInfoEntity?{
        didSet{
            textField.placeholder = editInfo?.placeHolderText
            textField.isEnabled = editInfo?.isEnable ?? false
            optionImageView.image = editInfo?.placeHolderImage
            
        }
    }
    

    
    
}
