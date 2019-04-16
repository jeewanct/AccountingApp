//
//  CreateProjectController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 19/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit
import ReusableFramework

enum CreateProjectTypeEnum: String{
    case create = "create"
    case edit = "edit"
}

class CreateProjectController: UIViewController{
    
    @IBOutlet var keyboardToolbar: UIToolbar!
    @IBOutlet weak var projectNameText: UITextField!
    @IBOutlet weak var startDateButton: UIButton!
    @IBOutlet weak var endDateButton: UIButton!
    @IBOutlet weak var assigneButton: UIButton!
    @IBOutlet weak var budgetPrice: UITextField!
    @IBOutlet weak var createProject: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        updateTitles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        getProjectAssignees()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func handleKeyboardDismiss(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func handleStartDate(_ sender: Any) {
        openCalendar()
    }
    
    @IBAction func handleEndDate(_ sender: Any) {
        openCalendar()
    }
    
    @IBAction func handleAssignee(_ sender: Any) {
        view.endEditing(true)
        let assigneeController = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "ProjectAssigneView") as! ProjectAssigneView
        assigneeController.modalTransitionStyle = .crossDissolve
        assigneeController.modalPresentationStyle = .overCurrentContext
        assigneeController.parentInstance = self
        if let assignees = selectedAssignee{
            assigneeController.selectedAssigneList = assignees
        }
        present(assigneeController, animated: true, completion: nil)
    }
    
    @IBAction func handleCreateProject(_ sender: Any) {
        checkForEmptyFields()
    }
    
    var screenType: CreateProjectTypeEnum!
    var createProjectEntity: CreateProjectEntity!
    var presenter: ViewToPresenterProtocol?
    var selectedAssignee: [ProjectAssigneeEntity]?{
        didSet{
            setupAssignees()
        }
    }
    
}


extension CreateProjectController: UITextFieldDelegate{
    
    func setupDelegates(){
        projectNameText.delegate = self
        budgetPrice.delegate = self
        projectNameText.inputAccessoryView = keyboardToolbar
        budgetPrice.inputAccessoryView = keyboardToolbar
        
        if createProjectEntity.type == CreateProjectTypeEnum.edit.rawValue{
            prefillFields()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case projectNameText:
            budgetPrice.becomeFirstResponder()
        default:
            view.endEditing(true)
        }
        return false
    }
}


extension CreateProjectController: CalendarDatesDelegate{
    
    func setCalendarDates(startDate: Date?, endDate: Date?) {
        if let startingDate = startDate {
            startDateButton.setTitle(Helper.convertDateToServerFormat(date: startingDate), for: .normal)
            
            createProjectEntity?.StartDate =  String(Helper.convertDateToTimeStamp(date: startingDate)) + "000"
            
        }
        
        if let endingDate = endDate{
            endDateButton.setTitle(Helper.convertDateToServerFormat(date: endingDate), for: .normal)
            
            createProjectEntity?.EndDate = String(Helper.convertDateToTimeStamp(date: endingDate)) + "000"
        }
    }
    
    
     func openCalendar(){
    view.endEditing(true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProjectCalendar") as! ProjectCalendar
        vc.modalTransitionStyle = .flipHorizontal
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    
    }
    
}

extension CreateProjectController{
    
    func  prefillFields(){
        projectNameText.text = createProjectEntity.ProjectName
        budgetPrice.text = createProjectEntity.ProjectBudGet
        assigneButton.setTitle(createProjectEntity.ProjectAssignTo, for: .normal)
        setCalendarDates(startDate: createProjectEntity.serverStartDate, endDate: createProjectEntity.serverEndDate)
        updateTitles()
    }
    
    func updateTitles(){
        if createProjectEntity.type == CreateProjectTypeEnum.edit.rawValue{
            navigationItem.title = ProjectEnum.editProjectTitle.rawValue
            createProject.setTitle(ProjectEnum.editProjectTitle.rawValue, for: .normal)
        }else{
            navigationItem.title = ProjectEnum.createProjectTitle.rawValue
            createProject.setTitle(ProjectEnum.createProjectTitle.rawValue, for: .normal)
        }
    }
    
    func setupAssignees(){
        if let assigneeList = selectedAssignee{
             let (assigneeTitle, assigneeServer) = Helper.createAssigneeList(list: assigneeList)
            assigneButton.setTitle(assigneeTitle, for: .normal)
            createProjectEntity.ProjectAssignTo = assigneeServer
        }
      
    }
    
    func checkForEmptyFields()  {
        
        if projectNameText.text == ""{
            self.showAlert(message: CreateProjectAlerts.projectName.rawValue)
        }else if createProjectEntity?.StartDate == CreateProjectContants.startDate.rawValue{
            self.showAlert(message: CreateProjectAlerts.startDate.rawValue)
        }else if createProjectEntity?.EndDate == CreateProjectContants.startDate.rawValue{
            self.showAlert(message: CreateProjectAlerts.endDate.rawValue)
        }else if  createProjectEntity?.ProjectAssignTo == CreateProjectAlerts.assignee.rawValue{
            self.showAlert(message: CreateProjectAlerts.assignee.rawValue)
        }else if budgetPrice.text == ""{
            self.showAlert(message: CreateProjectAlerts.budget.rawValue)
        }else{
            if Reachability.isConnectedToNetwork(){
                handleRetry()
            }else{
                self.notInternetView()
            }
            
        }
        
    }
    
    func handleRetry(){
        
        createProjectEntity.ProjectName = projectNameText.text
        createProjectEntity.ProjectBudGet = budgetPrice.text
        if Reachability.isConnectedToNetwork(){
            showIndicator()
            presenter?.updateView(body: createProjectEntity)
        }
        
    }
    
    func showIndicator(){
        self.view.isUserInteractionEnabled = false
        
        
        
         createProject.showActvityIndicator()
    }
    func hideIndicator(){
        self.view.isUserInteractionEnabled = true
        
        if createProjectEntity.type == CreateProjectTypeEnum.edit.rawValue{
            createProject.hideActivityIndicator(title: CreateProjectContants.editProject.rawValue)
        }else{
            createProject.hideActivityIndicator(title: CreateProjectContants.createProject.rawValue)
        }
        
    }
    
}

extension CreateProjectController: PresenterToViewProtocol{
    
    func getProjectAssignees(){
        assigneButton.addButtonIndicator()
        presenter?.updateView()
    }
    
    func showContent<T>(news: T) {
        hideIndicator()
        assigneButton.hideButtonIndicator(title: CreateProjectContants.assigne.rawValue)
        
        
        if let message  = news as?  (String?, Bool?){
            if message.1 == true{
                self.showAlert(message: message.0!)
            }else{
                
                let alertController = UIAlertController(title: "", message: message.0 ?? "", preferredStyle: .actionSheet)
                let okAction = UIAlertAction(title: CreateProjectContants.okAction.rawValue, style: .default) { (action) in
                    self.navigationController?.popViewController(animated: true)
                }
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
                
            }
        }
        
        if let list = news as? [ProjectAssigneeEntity]{
            if createProjectEntity.type == CreateProjectTypeEnum.edit.rawValue{
                if let assigneeList =  Helper.getEmployeeIdFromString(assignIds: list, assignId: createProjectEntity.ProjectAssignTo){
                    selectedAssignee = assigneeList
                }
            }
           
        }
        
    }
    
    func showError<T>(error: T) {
        if let message = error as? String{
            assigneButton.hideButtonIndicator(title: CreateProjectContants.assigne.rawValue)
            self.showAlert(message: message)
        }
        
    }
    
}

