//
//  CreateSubgroupCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 18/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class CreateSubgroupCell: UITableViewCell{
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var groupNameText: UITextField!
    
    @IBOutlet weak var searchMemberText: UITextField!
    
    @IBOutlet weak var createSubGroupBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTableView()
    }
    
    
}


extension CreateSubgroupCell: UITableViewDataSource{
    
    func configureTableView(){
        tableView.register(UINib(nibName: "CheckUncheckCell", bundle: nil), forCellReuseIdentifier: "CheckUncheckCell")
        tableView.dataSource = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckUncheckCell", for: indexPath) as! CheckUncheckCell
        return cell
    }
    
}
