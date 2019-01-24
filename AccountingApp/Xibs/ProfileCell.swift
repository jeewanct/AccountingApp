//
//  ProfileCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell{
    
    @IBOutlet weak var optionImageView: UIImageView!
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func hideActivityIndicator(){
       self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    func showActivityIndicator(){
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }

}
