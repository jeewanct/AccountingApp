//
//  InvoiceDetailCollectionCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 21/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

class InvoiceDetailCollectionCell: UICollectionViewCell{
    
    @IBOutlet weak var tableView: UITableView!
    var invoiceDetail: [InvoiceDetailOption]?{
        didSet{
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
}

extension InvoiceDetailCollectionCell{
    func configure(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setup(){
        tableView.reloadData()
    }
}
extension InvoiceDetailCollectionCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invoiceDetail?.count ?? 0 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceDetailInfoCell") as! InvoiceDetailInfoCell
        cell.invoice = invoiceDetail?[indexPath.item]
        return cell
    }
    
    
}
