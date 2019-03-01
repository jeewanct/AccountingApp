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
    
    @IBOutlet weak var searchMemberText: UISearchBar!
    
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var createSubGroupBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    var subGroupInfo: SubGroupUIEntity?{
        didSet{
            setData()
        }
    }
    
    var assigneeList: [ProjectAssigneeEntity]?{
        didSet{
            searchAssigneeList = assigneeList
            tableView.reloadData()
        }
    }
    
    var parentInstance: CreateSubGrouController?
    var searchAssigneeList: [ProjectAssigneeEntity]?
    var selectedAssignees = [String?: String?](){
        didSet{
            parentInstance?.subGroupEntity?.SubGroupMember = Helper.createAssigneeList(list: selectedAssignees)
        }
    }
    
}


extension CreateSubgroupCell{
    func setData(){
        projectName.text = subGroupInfo?.groupName
    }
}

extension CreateSubgroupCell: UITableViewDelegate, UITableViewDataSource{
    
    func configure(){
        tableView.delegate = self
        tableView.dataSource = self
        searchMemberText.delegate = self
        tableView.register(UINib(nibName: "CheckUncheckCell", bundle: nil), forCellReuseIdentifier: "CheckUncheckCell")
        
        for subview in searchMemberText.subviews.last!.subviews {
            if subview.isKind(of: NSClassFromString("UISearchBarTextField")!) {
                for v in subview.subviews {
                    if v.isKind(of: NSClassFromString("_UISearchBarSearchFieldBackgroundView")!) {
                        v.removeFromSuperview()
                    }
                }
            }
        }

        groupNameText.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return searchAssigneeList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckUncheckCell", for: indexPath) as! CheckUncheckCell
        cellType(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func cellType(cell: CheckUncheckCell, indexPath: IndexPath){
        if cell.isSelected{
            selectedState(indexPath: indexPath)
        }else{
            deselectedState(indexPath: indexPath)
        }
        
        switch indexPath.section{
        case 0:
            cell.optionLabel.text = "All"
        default:
            cell.optionLabel.text = searchAssigneeList?[indexPath.item].name
        }
    }
    
}

extension CreateSubgroupCell{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedState(indexPath: indexPath)
        selectedAssignees.updateValue(searchAssigneeList?[indexPath.item].name, forKey: searchAssigneeList?[indexPath.item].id)
        switch indexPath.section{
        case 0:
            if let count = searchAssigneeList?.count{
                for index in 0..<count{
                    tableView.selectRow(at: IndexPath(item: index, section: 1), animated: false, scrollPosition: .none)
                    self.tableView(tableView, didSelectRowAt: IndexPath(item: index, section: 1))
                }
            }
        default:
            print("")
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        deselectedState(indexPath: indexPath)
       
    selectedAssignees.removeValue(forKey: searchAssigneeList?[indexPath.item].id)
        
        switch indexPath.section{
        case 0:
            if let count = searchAssigneeList?.count{
                for index in 0..<count{
                    tableView.deselectRow(at: IndexPath(item: index, section: 1), animated: false)
                    self.tableView(tableView, didDeselectRowAt: IndexPath(item: index, section: 1))
                    
                }
            }
        default:
            print("")
            //            tableView.deselectRow(at: IndexPath(item: 0, section: 0), animated: false)
            //             self.tableView(tableView, didDeselectRowAt: IndexPath(item: 0, section: 0))
        }
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


extension CreateSubgroupCell: UISearchBarDelegate, UISearchDisplayDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchAssigneeList = searchText.isEmpty ? assigneeList : assigneeList?.filter({ (hotel) -> Bool in
            return hotel.name?.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        tableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}

extension CreateSubgroupCell: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        parentInstance?.subGroupEntity?.SubGroupName = groupNameText.text
        return true
    }
}
