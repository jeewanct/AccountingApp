//
//  ProjectDateCollectionCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 21/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

class ProjectDateCollectionCell: UICollectionViewCell{
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var dateDetail: ProjectDateEntity?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup(){
        dayLabel.text = dateDetail?.day
        dateLabel.text = dateDetail?.date
    }
    

    
}
