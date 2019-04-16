//
//  TaskController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 19/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit
import ReusableFramework
class TaskController: UIViewController{
    
    @IBOutlet weak var selectProjectBtn: UIButton!
    @IBOutlet weak var taskNameLabel: UITextField!
    @IBOutlet weak var taskDateBtn: UIButton!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet var keyboardToolBar: UIToolbar!
    @IBOutlet weak var hourBtn: UIButton!
    @IBOutlet weak var minBtn: UIButton!
    
    var details = TaskUIEntity()
    var taskEntity: TaskCreateEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDelegates()
        navigationItem.title = ProjectEnum.Tasktitle.rawValue
        prefillValues()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func handleDismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func handleProject(_ sender: Any) {
        let customPopUp = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "CustomPopUpController") as! CustomPopUpController
        customPopUp.projectList = details.projectList
        customPopUp.delegate = self
        customPopUp.modalTransitionStyle = .crossDissolve
        customPopUp.modalPresentationStyle = .overCurrentContext
        present(customPopUp, animated: true, completion: nil)
    }
    
    @IBAction func handleTaskDate(_ sender: Any) {
        if selectProjectBtn.title(for: .normal) == TaskConstants.selectProject.rawValue{
            self.showAlert(message: TaskAlerts.selectProject.rawValue)
        }else{
            openCalendar()
        }
        
    }
    
    @IBAction func handleSelectHrs(_ sender: Any) {
        details.type = TaskPopEnum.hours
        let customPopUp = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "GenericPopUp") as! GenericPopUp
        customPopUp.parentInstance = self
        customPopUp.list = details.hours
        customPopUp.modalTransitionStyle = .crossDissolve
        customPopUp.modalPresentationStyle = .overCurrentContext
        present(customPopUp, animated: true, completion: nil)
        
    }
    @IBAction func handleSelectMins(_ sender: Any) {
        details.type = TaskPopEnum.minutes
        let customPopUp = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "GenericPopUp") as! GenericPopUp
        customPopUp.parentInstance = self
        customPopUp.list = details.minutes
        customPopUp.modalTransitionStyle = .crossDissolve
        customPopUp.modalPresentationStyle = .overCurrentContext
        present(customPopUp, animated: true, completion: nil)
    }
    
    
    @IBAction func handleSave(_ sender: Any) {
        checkForEmptyFields()
    }
    
    var presenter: ViewToPresenterProtocol?
    
}



// Setup Keyboard
extension TaskController: UITextFieldDelegate{
    
    func addDelegates(){
        taskNameLabel.delegate = self
        descriptionText.delegate = self
        taskNameLabel.inputAccessoryView = keyboardToolBar
        descriptionText.inputAccessoryView = keyboardToolBar
    }
    
    func prefillValues(){
        
        if taskEntity.type == CreateProjectTypeEnum.edit.rawValue{
            navigationItem.title = TaskConstants.editTask.rawValue
            saveBtn.setTitle(TaskConstants.editTask.rawValue, for: .normal)
            setData()
        }else{
            navigationItem.title = TaskConstants.createTask.rawValue
            saveBtn.setTitle(TaskConstants.createTask.rawValue, for: .normal)
            presenter?.updateView()
            selectProjectBtn.addButtonIndicator()
        }
        
    }
    
    func setData(){
        taskNameLabel.text = taskEntity.Tasks
        setCalendarDates(startDate: taskEntity.selectedDate, endDate: nil)
        hourBtn.setTitle(taskEntity.Hours, for: .normal)
        minBtn.setTitle(taskEntity.Minutes, for: .normal)
        descriptionText.text = taskEntity.Description
       selectProjectBtn.setTitle(taskEntity.projectName, for: .normal)
        selectProjectBtn.isUserInteractionEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case taskNameLabel:
            descriptionText.becomeFirstResponder()
        default:
            self.view.endEditing(true)
        }
        return false
    }
    
}

extension TaskController: CalendarDatesDelegate, ProjectSelectedDelegate{
    
    func didSelectedProject(withName name: String?, andProjectId projectId: String?,startDate: Date?, endDate: Date?) {
        selectProjectBtn.setTitle(name, for: .normal)
        taskEntity.ProjectId = projectId
        taskEntity.serverStartDate = startDate
        taskEntity.serverEndDate = endDate
    }
    
    func setCalendarDates(startDate: Date?, endDate: Date?) {
        if let getDate = startDate{
            taskDateBtn.setTitle(Helper.convertDateToServerFormat(date: getDate), for: .normal)
            taskEntity.CreateDate =  String(Helper.convertDateToTimeStamp(date: getDate)) + "000"
            taskEntity.selectedDate = getDate
            
        }
    }
    
    func openCalendar(){
        view.endEditing(true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TaskCalendar") as! TaskCalendar
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .overCurrentContext
        if let selectedDate = taskEntity.selectedDate{
            vc.startDate = selectedDate
        }else{
             vc.startDate = taskEntity.serverStartDate
        }
        if let startDate = taskEntity.serverStartDate,let endDate = taskEntity.serverEndDate{
            vc.projectStartingDate = startDate
            vc.projectEndingDate = endDate
        }
        
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension TaskController{
    
    func checkForEmptyFields()  {
        
        if selectProjectBtn.title(for: .normal) == TaskConstants.selectProject.rawValue{
            self.showAlert(message: TaskAlerts.selectProject.rawValue)
        }else if taskNameLabel?.text == ""{
            self.showAlert(message: TaskAlerts.task.rawValue)
        }else if taskDateBtn.title(for: .normal) == TaskConstants.taskDate.rawValue{
            self.showAlert(message: TaskAlerts.taskDate.rawValue)
        }else if  hourBtn.title(for: .normal) == "0" && minBtn.title(for: .normal) == "0" {
            self.showAlert(message: TaskAlerts.selectMins.rawValue)
        }else if descriptionText.text == ""{
            self.showAlert(message: TaskAlerts.description.rawValue)
        }else{
            if Reachability.isConnectedToNetwork(){
                handleRetry()
            }else{
                self.notInternetView()
            }
            
        }
        
    }
    
    func handleRetry(){
        
        taskEntity.Tasks = taskNameLabel.text
        taskEntity.Description = descriptionText.text
        
        if Reachability.isConnectedToNetwork(){
            showIndicator()
            presenter?.updateView(body: taskEntity)
        }
        
    }
    
    func showIndicator(){
        self.view.isUserInteractionEnabled = false
        saveBtn.showActvityIndicator()
    }
    func hideIndicator(){
        self.view.isUserInteractionEnabled = true
        if taskEntity.type == CreateProjectTypeEnum.edit.rawValue{
            saveBtn.hideActivityIndicator(title: TaskConstants.editTask.rawValue)
        }else{
            saveBtn.hideActivityIndicator(title: TaskConstants.createTask.rawValue)
        }
    }
}


extension TaskController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        
            selectProjectBtn.hideButtonIndicator(title: TaskConstants.selectProject.rawValue)
        
        if let projectList = news as? [CameraProjectUIEntity]{
            details.projectList = projectList
        }
        
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
        
    }
    
    func showError<T>(error: T) {
        selectProjectBtn.hideButtonIndicator(title: TaskConstants.selectProject.rawValue)
    }
    
}

