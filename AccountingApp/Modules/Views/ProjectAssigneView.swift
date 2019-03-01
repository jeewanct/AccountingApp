//
//  ProjectAssigneView.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 09/02/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

protocol SelectedAssigneeDelegate{
    func selectedAssignee(list: [ProjectAssigneeEntity])
}

class ProjectAssigneView: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dismissView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var keyboardToolbar: UIToolbar!
    
    var assigneeList: [ProjectAssigneeEntity]?{
        didSet{
            searchAssigneeList = assigneeList
        }
    }
    var searchAssigneeList: [ProjectAssigneeEntity]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
   @objc  @IBAction func handleClose(sender: Any){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleSubmit(sender: Any){
        if let indexPaths = tableView.indexPathsForSelectedRows{
            
        }
        handleClose(sender: "")
    }
    
    @IBAction func handleDismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
}

extension ProjectAssigneView: UITableViewDelegate, UITableViewDataSource{
    
    func configure(){
        tableView.register(UINib(nibName: "CheckUncheckCell", bundle: nil), forCellReuseIdentifier: "CheckUncheckCell")
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
          assigneeList =  ProjectAssigneeDatabase.getList(appdelegate: appDelegate)
            tableView.reloadData()
        }
        searchBar.delegate = self
        searchBar.inputAccessoryView = keyboardToolbar
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleClose(sender:)))
        dismissView.addGestureRecognizer(tapGesture)
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


extension ProjectAssigneView{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedState(indexPath: indexPath)
        switch indexPath.section{
        case 0:
            if let count = searchAssigneeList?.count{
                for index in 0..<count{
                     tableView.selectRow(at: IndexPath(item: index, section: 1), animated: false, scrollPosition: .none)
                    self.tableView(tableView, didSelectRowAt: IndexPath(item: index, section: 1))
                   // tableView(self.tableView, didSelectRowAt: IndexPath(item: index, section: 1))
                }
            }
        default:
            print("")
            
//            tableView.deselectRow(at: IndexPath(item: 0, section: 0), animated: true)
     //       self.tableView.deselectRow(at: IndexPath(item: 0, section: 0), animated: true)
           // tableView(self.tableView, didSelectRowAt: IndexPath(item: 0, section: 0))
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        deselectedState(indexPath: indexPath)
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


extension ProjectAssigneView: UISearchBarDelegate, UISearchDisplayDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchAssigneeList = searchText.isEmpty ? assigneeList : assigneeList?.filter({ (hotel) -> Bool in
            return hotel.name?.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        tableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
//    @objc func handleSubmit(){
//        let assignIds = LogicHelper.attachUserId(userId: ifProjectIdAvailable)
//
//        delegate?.onClickCell(value: assignIds)
//        handleClose()
//    }
    
    
    //    func setPrefilledValue(){
    //
    //    if let searchData = projectSearchData, let availableIds = ifProjectIdAvailable{
    //
    //    for index in 0..<searchData.count{
    //
    //        for (_, value) in availableIds{
    //
    //            if value == searchData[index].ID{
    //                 self.tableView(contentTable, didSelectRowAt: IndexPath(item: index, section: 0))
    //            }
    //
    //        }
    //
    //
    //    }
    //    }
    //    }
    
    
}
