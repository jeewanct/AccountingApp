//
//  InvoiceCollectionCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

class InvoiceCollectionCell: UICollectionViewCell{
    
    @IBOutlet weak var tableView: UITableView!
       var delegate: CellClicked?
    
    var invoiceList: [InvoiceDetailEntity]?{
        didSet{
            tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
}


extension InvoiceCollectionCell{
    
    func setup(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "InvoiceTableCell", bundle: nil), forCellReuseIdentifier: "InvoiceTableCell")
        
    }
    
}


extension InvoiceCollectionCell: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UIScreen.main.bounds.height * 0.12
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invoiceList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceTableCell", for: indexPath) as! InvoiceTableCell
        cell.invoice = invoiceList?[indexPath.item]
        return cell
    }
    
}

extension InvoiceCollectionCell{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.cellClicked(data: invoiceList?[indexPath.item])
    }
}
