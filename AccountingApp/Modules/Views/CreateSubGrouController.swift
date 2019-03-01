//
//  CreateSubGrouController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 18/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit
import ReusableFramework

class CreateSubGrouController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var hideKeyboard: UIToolbar!
    
    @IBOutlet weak var createSubgroupBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
   
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func handleCreate(_ sender: Any) {
        checkEmptyField()
        print("")
    }
    var assigneeList: [ProjectAssigneeEntity]?{
        didSet{
            searchAssigneeList = assigneeList
        }
    }
    var searchAssigneeList: [ProjectAssigneeEntity]?
    var presenter: ViewToPresenterProtocol?
    var subGroupEntity: SubGroupUIEntity?
}

extension CreateSubGrouController: UITableViewDelegate, UITableViewDataSource{

    func configure(){
         navigationItem.title = GroupMessageEnum.createSubGroup.rawValue
        tableView.register(UINib(nibName: "CreateSubgroupCell", bundle: nil), forCellReuseIdentifier: "CreateSubgroupCell")
    presenter?.updateView()
    }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height - self.navigationBarHeight
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreateSubgroupCell", for: indexPath) as! CreateSubgroupCell
        cell.assigneeList = searchAssigneeList
        cell.subGroupInfo = subGroupEntity
        cell.parentInstance = self
        return cell
    }

}

extension CreateSubGrouController{
    func checkEmptyField(){
        if subGroupEntity?.SubGroupName == ""{
            self.showAlert(message: CreateSubGroupEnum.groupName.rawValue)
        }else if subGroupEntity?.SubGroupName == ""{
            self.showAlert(message: CreateSubGroupEnum.members.rawValue)
        }else{
            if Reachability.isConnectedToNetwork(){
                createSubGroup()
            }else{
                self.notInternetView()
            }
        }
    }
    
    func createSubGroup(){
        createSubgroupBtn.addButtonIndicator()
        presenter?.updateView(body: subGroupEntity!)
    }
    
    func askForBack(){
        let alertController = UIAlertController(title: "", message: CreateSubGroupEnum.subGroupCreated.rawValue, preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: CreateSubGroupEnum.ok.rawValue, style: .default) { (value) in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension CreateSubGrouController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        createSubgroupBtn.hideButtonIndicator(title: CreateSubGroupEnum.createSubgroup.rawValue)
        if let _ = news as? [ProjectAssigneeEntity]{
            //searchAssigneeList = assigneeList
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
                searchAssigneeList =  ProjectAssigneeDatabase.getList(appdelegate: appDelegate)
                tableView.reloadData()
            }
        }
        
        if let createGroup = news as? Bool{
            if !createGroup{
                askForBack()
            }else{
                self.showAlert(message: CreateSubGroupEnum.subGroupError.rawValue)
            }
        }
    }
    
    func showError<T>(error: T) {
        createSubgroupBtn.hideButtonIndicator(title: CreateSubGroupEnum.createSubgroup.rawValue)
        if let getError = error as? String{
            self.showAlert(message: getError)
        }
    }
    
}

