//
//  GroupController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 03/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class GroupController: UITableViewController{
    
    var presenter: ViewToPresenterProtocol?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureTableView()
    
    }
    
    var expandedSection: Int?
}

extension GroupController{
    
    func configureTableView(){
        
        tableView.register(UINib(nibName: "GroupCell", bundle: nil), forCellReuseIdentifier: "GroupCell")
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let section = expandedSection {
            if section == indexPath.section{
                return UITableView.automaticDimension
            }else{
                return 0
            }
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        return cell
        
    }
    
}

extension GroupController{
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header: GroupHeader = UIView.fromNib()
        header.headerSection = section
        header.delegate = self
        return header
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 58
        
        
    }
    
    
}


extension GroupController: ExpandTableCellDelegate{
    
    func expandingTableCell(at section: Int) {
        
        if expandedSection == section{
            expandedSection = nil
        }else{
            expandedSection = section
        }
        
        let indexSet = IndexSet(arrayLiteral: section)
        tableView.reloadSections(indexSet, with: .fade)
        
    }
    
    func detailOfGroup(at section: Int) {
        
    }
    
}


extension GroupController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        
        
        
    }
    
    func showError() {
        
    }
    
}
