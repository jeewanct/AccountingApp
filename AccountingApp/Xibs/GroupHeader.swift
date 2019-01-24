//
//  GroupHeader.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 10/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit



class GroupHeader: UIView {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subGroupLbl: UIButton!
    @IBOutlet weak var subGroupHeight: NSLayoutConstraint!
    @IBOutlet weak var betweenHeight: NSLayoutConstraint!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    weak var delegate: ExpandTableCellDelegate?
    var headerSection: Int!
    
    
}

//MARK: Adding touch gesture in self

extension GroupHeader{
    
    func setupView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
        
        subGroupLbl.addTarget(self, action: #selector(handleExpandCells), for: .touchUpInside)
    }

}

extension GroupHeader{

    @objc func handleTap(){
        delegate?.detailOfGroup(at: headerSection)
    }
    
    @objc func handleExpandCells(){
        delegate?.expandingTableCell(at: headerSection)
    }
}

extension GroupHeader{
    
    func fillData(groupName: String?, subGroups: String?){
        titleLbl.text = groupName
        
        if subGroups == ""{
            subGroupHeight.constant = 0
            betweenHeight.constant = 0
            subGroupLbl.isHidden = true
        }else{
            subGroupLbl.setTitle(subGroups, for: .normal)
            subGroupHeight.constant = 20
            betweenHeight.constant = 4
            subGroupLbl.isHidden = false
        }
    }
}

//MARK: Defining protocol for expandable View

protocol ExpandTableCellDelegate: class{
    func expandingTableCell(at section: Int)
    func detailOfGroup(at section: Int)
}
