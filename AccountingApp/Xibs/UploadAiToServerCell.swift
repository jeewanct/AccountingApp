//
//  UploadAiToServerCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 03/03/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class UploadAiToServerCell: UICollectionViewCell{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalAmout: UILabel!
    @IBOutlet weak var tax: UILabel!
    var section: Int!
    weak var parentInstance:UploadInvoiceController?
    
    var uploadInvoice: MultiAiModel?{
        didSet{
            setup()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
}

extension UploadAiToServerCell{
    func setup(){
        if let amount = uploadInvoice?.total_amount{
            totalAmout.text = "$\(amount)"
        }
        tax.text = uploadInvoice?.tax
    }
}
//MARK: Collection view delegate and datasource
extension UploadAiToServerCell: UITableViewDelegate, UITableViewDataSource{
    
    func configure(){
        tableView.register(UINib(nibName: "CheckUncheckCell", bundle: nil), forCellReuseIdentifier: "CheckUncheckCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return uploadInvoice?.cvr?.count ?? 0
        default:
            return uploadInvoice?.date?.count ?? 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckUncheckCell") as! CheckUncheckCell
        if indexPath.item == 0 {
            cell.optionLabel.text = uploadInvoice?.cvr?[indexPath.item]
        }else{
            cell.optionLabel.text = uploadInvoice?.date?[indexPath.item]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let lbl = UILabel()
        lbl.text = "CVR"
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        lbl.textColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        lbl.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(lbl)
        lbl.anchorWithConstantsToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 16)
        
        if section == 0 {
            lbl.text = "CVR"
        }else{
            lbl.text = "Date"
        }
        return view
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedState(indexPath: indexPath)
        switch indexPath.section {
        case 0:
            parentInstance?.invoice?.aiData?[section].selectedCvr =  uploadInvoice?.cvr?[indexPath.item]
        default:
            parentInstance?.invoice?.aiData?[section].selectedDate =  uploadInvoice?.cvr?[indexPath.item]
        }
        parentInstance?.collectionView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        deselectedState(indexPath: indexPath)
    }
    func selectedState(indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath) as? CheckUncheckCell
        cell?.checkImage.image = #imageLiteral(resourceName: "checkImage")
    }
    
    func deselectedState(indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath) as? CheckUncheckCell
        cell?.checkImage.image = #imageLiteral(resourceName: "uncheckImage")
    }
    
    
    
}

extension UploadAiToServerCell{
    
    
}
