//
//  InvoiceDetailInfoCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 02/03/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class InvoiceDetailInfoCell: UITableViewCell{
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    var invoice: InvoiceDetailOption?{
        didSet{
            setup()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}

extension InvoiceDetailInfoCell{
    func setup(){
        titleLbl.text = invoice?.title
        valueLbl.text = invoice?.option
    }
}
