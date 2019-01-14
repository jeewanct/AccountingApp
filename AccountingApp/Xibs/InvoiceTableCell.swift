//
//  InvoiceTableCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

class InvoiceTableCell: UITableViewCell{
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
   
    var invoice: Invoices?{
        didSet{
            dateLabel.text = invoice?.date
            costLabel.text = invoice?.cost
            detailLabel.text = invoice?.detail
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
