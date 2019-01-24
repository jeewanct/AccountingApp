//
//  ProjectInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit
import RxSwift
import ReusableFramework

class ProjectInteractor: PresentorToInterectorProtocol, APIRequest {
    
    var method: RequestType
    var path: String
    var parameters: Data
    var headers: [String : String]
    var errorMessage = ""
    var projectListModel: [ProjectListModel]?
    var appDelegate: AppDelegate!
    
    
    init() {
        method = RequestType.GET
        let (_, companyId) = UserHelper.companyID()
        path = ProjectApis.projectUrl + GlobalConstants.companyId1 + "\(companyId)" + GlobalConstants.pageNumber + "1"
        parameters = Data()
        headers = path.getHeader()
        
        if let appDelegateInstance = UIApplication.shared.delegate as? AppDelegate{
            appDelegate = appDelegateInstance
        }
        
    }
    
    var presenter: InterectorToPresenterProtocol?
    
    
}

extension ProjectInteractor{
    func fetchData<T>(body: T) where T : Decodable, T : Encodable {
        
        guard let projectDates = body as? ProjectDate else {return}
        
        path.append(GlobalConstants.startDate + "\(projectDates.startDate)" + GlobalConstants.endDate + "\(projectDates.endDate)")
        
        let projectList: Observable<ProjectListApiModel> = Network.shared.get(apiRequest: self)
        
        projectList.subscribe(onNext: { (response) in
          
            if response.error == true{
                
                if let message = response.message{
                    
                    if response.code == ErrorCodeEnum.logout.rawValue{
                        self.errorMessage = ErrorCodeEnum.logout.rawValue
                    }else{
                        self.errorMessage = message
                    }
                }
            }else{
               
                if let projects = response.data{
                    self.projectListModel = projects
                    
                    
                    
                    
                   // print(dump(projects))
                }
                
            }
            
            
        }, onError: { (error) in
            
            self.presenter?.dataFetchedFailed(error: error.localizedDescription)
            
        }, onCompleted: {
            
            if self.errorMessage == ""{
                self.getTasks()
            }else{
                self.presenter?.dataFetchedFailed(error: self.errorMessage)
                self.errorMessage = ""
            }
            
        }) {
            
        }
        
        
        
        
    }
    
    
    func getTasks(){
        
        guard let projects = projectListModel else {
            
            return
        }
        
        
        let projectList = projects.map { (projectList) -> Observable<ProjectTaskApiModel>? in
            
            if let projectId = projectList.ProjectID{
                self.path = ProjectApis.projectTaskUrl + GlobalConstants.projectId + "\(projectId)" + GlobalConstants.startDate + "0" + GlobalConstants.endDate + "0"
                
                return Network.shared.get(apiRequest: self)
            }
            
            return nil
            
        }
        
        
        for index in  0..<projectList.count{
            if let unwrappedProject = projectList[index]{
                
                unwrappedProject.subscribe(onNext: { (task) in
                   self.projectListModel?[index].projectTasks = task.data
                }, onError: { (error) in
                    self.projectListModel?[index].projectTasks = nil
                }, onCompleted: {
                    if index == projectList.count - 1{
                        self.saveToDatabase()
                    }
                }) {
                    
                }
                
            }
        }
        
        
//        for index in 0..<projects.count{
//
//
//            if let projectId = projects[index].ProjectID{
//                path = ProjectApis.projectTaskUrl + GlobalConstants.projectId + "\(projectId)" + GlobalConstants.startDate + "0" + GlobalConstants.endDate + "0"
//
//
//                let projectTasks: Observable<ProjectTaskApiModel> = Network.shared.get(apiRequest: self)
//
//                projectTasks.subscribe(onNext: { (response) in
//
//                    print(index)
//                    if let task = response.data{
//                        self.projectListModel?[index].projectTasks = task
//                    }
//
//
//                }, onError: { (error) in
//
//                }, onCompleted: {
//
//                    if index + 1 == self.projectListModel?.count{
//                        self.saveToDatabase()
//                    }
//
//
//                }) {
//
//                }
//
//            }
//
//        }
        
        
    }
    
    func fetchData() {
        
    }
    
    func saveToDatabase(){
        
        if let projects = projectListModel{
            
           let projectList =  ProjectDatabase.saveProjects(projects: projects, appdelegate: appDelegate)
            self.presenter?.dataFetched(news: projectList)
        }
        
        
        
    }
    
}
