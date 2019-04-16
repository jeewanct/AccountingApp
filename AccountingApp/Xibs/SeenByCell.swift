//
//  SeenByCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 04/03/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class SeenByCell: UITableViewCell {

    @IBOutlet weak var optionImage: UIImageView!
    @IBOutlet weak var optionLbl: UILabel!
    
    var seenBy: SeenByDataModel?{
        didSet{
            setup()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SeenByCell{
    func setup(){
        optionImage.addImage(url: seenBy?.ImageUrl)
        optionLbl.text = Helper.getFullName(firstName: seenBy?.FirstName, lastName: seenBy?.LastName)
    }
}
