//
//  ProjectsController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

class ProjectsController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addProjectBtn: UIButton!
    @IBOutlet weak var notTasks: UILabel!
    @IBOutlet weak var reloadBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.hideTranslucency()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Projects"
        clearData(startDate: 0, endDate: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
    }
    
    
    @IBAction func handleAddTask(_ sender: Any) {
        let createTask = TaskCreateEntity(projectId: "", type: CreateProjectTypeEnum.create.rawValue)
        createTask.selectedDate = Date()
        addTask(task: createTask)
    }
    
    @IBAction func handleProjectCalendar(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProjectCalendar") as! ProjectCalendar
        vc.modalTransitionStyle = .flipHorizontal
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func handleReload(_ sender: Any) {
        clearData(startDate: 0, endDate: 0)
    }
    
    @IBAction func handleAddProjects(_ sender: Any) {
        
        let createProject = CreateProjectRoute.createModule() as! CreateProjectController
        let createEntity = CreateProjectEntity(projectId: "", createdBy: "", type: CreateProjectTypeEnum.create.rawValue)
        createProject.createProjectEntity = createEntity
        navigationController?.pushViewController(createProject, animated: true)
        
    }
    
    
    
    var presenter: ViewToPresenterProtocol?
    var projectEntity = PojectEntity()
    
}

extension ProjectsController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0,1: return 1
        default: return projectEntity.currentDisplayTask?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section{
        case 0: return 200
        case 1: return 46 + 16 + 12
        default:
            return UITableView.automaticDimension
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectsCell", for: indexPath) as! ProjectsCell
            cell.projects = projectEntity.projectList
            cell.projectInstance = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectDateCell", for: indexPath) as! ProjectDateCell
            cell.dateList = projectEntity.currentDisplayDate
            cell.projectInstance = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectTaskCell", for: indexPath) as! ProjectTaskCell
            cell.task = projectEntity.currentDisplayTask?[indexPath.item]
            return cell
   
        }
        
    }
    
}

extension ProjectsController{
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 2{
            return true
        }
        
        return false
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            self.deleteTask(item: indexPath)
        }
        deleteButton.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        let editButton = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            self.editTask(item: indexPath)
        }
        
        editButton.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        
        return [deleteButton, editButton]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let allProjects = AllProjectsRoutes.createModule()
//        navigationController?.pushViewController(allProjects, animated: true)
    }
}


extension ProjectsController{
    
    func deleteTask(item: IndexPath){
        
        
        if let task = projectEntity.currentDisplayTask?[item.item].editTaskName{
            let alertController = UIAlertController(title: ProjectAlerts.delete.rawValue + task, message: "", preferredStyle: .actionSheet)
            let okAction = UIAlertAction(title: ProjectEnum.okAction.rawValue, style: .default) { (value) in
                self.callDeleteTask(item: item)
            }
            let cancelAction = UIAlertAction(title: ProjectEnum.cancelAction.rawValue, style: .cancel, handler: nil)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
        
    }
    
    func editTask(item: IndexPath){
        let editTask = TaskCreateEntity(projectId: projectEntity.currentDisplayTask?[item.item].projectId, type: CreateProjectTypeEnum.edit.rawValue)
        
        let (startDate, endDate, projectName) = Helper.getStartAndEndDate(projectEntity: projectEntity, projectId: projectEntity.currentDisplayTask?[item.item].projectId)
        editTask.serverStartDate = startDate
        editTask.serverEndDate = endDate
        editTask.Hours = projectEntity.currentDisplayTask?[item.item].hours
        editTask.projectName = projectName
        editTask.Minutes = projectEntity.currentDisplayTask?[item.item].minute
        editTask.Description = projectEntity.currentDisplayTask?[item.item].taskDescription
        editTask.Tasks = projectEntity.currentDisplayTask?[item.item].editTaskName
        editTask.TaskId = projectEntity.currentDisplayTask?[item.item].taskId
        editTask.selectedDate = projectEntity.currentDisplayTask?[item.item].createdDate
        addTask(task: editTask)
    }
    
    func callDeleteTask(item: IndexPath){
        let deleteTask = ProjectTaskDelete(taskId: projectEntity.currentDisplayTask?[item.item].taskId)
        presenter?.updateView(body: deleteTask)
        let cell = tableView.cellForRow(at: item) as? ProjectTaskCell
        cell?.activityIndicator.isHidden = false
        cell?.activityIndicator.startAnimating()
    }
    
    func addTask(task: TaskCreateEntity){
        let addTask = TaskRoute.createModule() as! TaskController
        addTask.taskEntity = task
        navigationController?.pushViewController(addTask, animated: true)
    }
    
    func clearData(startDate: CLong, endDate: CLong){
        reloadBtn.isEnabled = false
        projectEntity = PojectEntity()
        tableView.reloadData()
        getProjects(startDate: startDate, endDate: endDate)
    }
    
    func getProjects(startDate: CLong, endDate: CLong){
        self.showDataIndicator()
        let projectDates = ProjectDate(startDate: startDate, endDate: endDate)
        presenter?.updateView(body: projectDates)
    }
    
    func handleEditProjects(editProject: CreateProjectEntity){
        let createProject = CreateProjectRoute.createModule() as! CreateProjectController
//        let editProject = CreateProjectEntity(projectId: projectEntity.projectList?[atSection].projectId, createdBy: "", type: CreateProjectTypeEnum.edit.rawValue)
        createProject.createProjectEntity = editProject
        navigationController?.pushViewController(createProject, animated: true)
    }
}

extension ProjectsController: CalendarDatesDelegate{
    func setCalendarDates(startDate: Date?, endDate: Date?) {
        if let startingDate = startDate, let endingDate = endDate{
            let startDat = String(Helper.convertDateToTimeStamp(date: startingDate)) + "000"
            let endDat = String(Helper.convertDateToTimeStamp(date: endingDate)) + "000"
            
            if let convertedStart = CLong(startDat), let convertedEnd = CLong(endDat){
                clearData(startDate: convertedStart, endDate: convertedEnd)
            }
            
        }
    }
}
extension ProjectsController: PresenterToViewProtocol {
    
    func showContent<T>(news: T) {
        reloadBtn.isEnabled = true
        self.hideDataIndicator()
        if let projects = news as? PojectEntity{
            self.projectEntity = projects
            if let isHidden = self.projectEntity.isCreateProjectHidden{
                addProjectBtn.isHidden = !isHidden
            }
            
            if let _ = projects.projectList {
                tableView.isHidden = false
                tableView.reloadData()
            }else{
                notTasks.isHidden = true
                 tableView.isHidden = true
            }
            
        }
        
        if let message  = news as?  (String?, Bool?){
            if message.1 == true{
                self.showAlert(message: message.0!)
            }else{
                clearData(startDate: 0, endDate: 0)
            }
        }
        
       
    }
    
    func showError<T>(error: T) {
        reloadBtn.isEnabled = true
        self.hideDataIndicator()
        if let errorMessage = error as? String{
            
            if errorMessage == ErrorCodeEnum.logout.rawValue{
                let alertController = UIAlertController(title: "", message: AlertMessage.sessionExpired.rawValue + UserHelper.nameOfUser() + "?", preferredStyle: .actionSheet)
                
                let okAction = UIAlertAction(title: AlertMessage.ok.rawValue, style: .default) { [unowned self] (action) in
                    UserHelper.logoutUser()
                    
                    DispatchQueue.main.async {
                        
                        ChangeRootViewController.changeRootViewController(to: ChangeToControllerEnum.LoginController)
                    }
                    
                }
                
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
            }else{
                self.sheetStyleAlert(message: errorMessage)
            }
            
        }
    }
    
    
    
}

