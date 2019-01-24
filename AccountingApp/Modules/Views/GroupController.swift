//
//  GroupController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 03/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit
import ReusableFramework


class GroupController: UITableViewController{
    
    var presenter: ViewToPresenterProtocol?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureTableView()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
        navigationItem.title = "Groups"
        
        if Reachability.isConnectedToNetwork(){
            presenter?.updateView()
        }else{
            self.notInternetView()
        }
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
        tabBarController?.tabBar.isHidden = false
    }
    
    var groupList: [GroupsEntity]?
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
        return groupList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupList?[section].subGroups?.count ?? 0
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
        cell.subGroupName.text = groupList?[indexPath.section].subGroups?[indexPath.item].subGroupName
        return cell
        
    }
    
}

extension GroupController{
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header: GroupHeader = UIView.fromNib()
        header.headerSection = section
        header.delegate = self
        header.fillData(groupName: groupList?[section].groupName, subGroups: groupList?[section].numberOfSubGroups)
        return header
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if groupList?[section].numberOfSubGroups == ""{
            return 52
        }
        
        return 76
        
    }
    
    
}

extension GroupController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let messages = GroupMessageRoute.createModule() as? GroupMessagesController
        let groupId = groupList?[indexPath.section].groupId
        let subGroupId = groupList?[indexPath.section].subGroups?[indexPath.item].subGroupId
        messages?.messageParams = (groupId, subGroupId)
        navigationController?.pushViewController(messages ?? UIViewController(), animated: true)
        
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

        let messages = GroupMessageRoute.createModule() as? GroupMessagesController
        
        let groupId = groupList?[section].groupId
        messages?.messageParams = (groupId, nil)
        
        navigationController?.pushViewController(messages ?? UIViewController(), animated: true)
        
    }
    
}


extension GroupController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        
        if let data = news as? [GroupsEntity]{
            groupList = data
            tableView.reloadData()
        }
        
    }
    
    func showError<T>(error: T) {
        if let error = error as? String{
            self.showAlert(message: error)
        }
    }
    
}
