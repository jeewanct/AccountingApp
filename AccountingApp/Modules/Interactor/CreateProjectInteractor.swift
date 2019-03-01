//
//  CreateProjectInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 19/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//



import RxSwift
import Foundation
import ReusableFramework


class CreateProjectInteractor: PresentorToInterectorProtocol, APIRequest{
    
    var method: RequestType
    var path: String
    var parameters: Data?
    var headers: [String : String]
    var presenter: InterectorToPresenterProtocol?
    var message: (String?, Bool?)
    var assigneeList: [AssigneDetailEntity]?
    var appdelegate: AppDelegate!
    init() {
        method = RequestType.GET
        path =  LoginApis.getAssignIds + "/\(UserHelper.companyID().1)"
        headers = path.getHeader()
        if let getAppDelegate = UIApplication.shared.delegate as? AppDelegate{
            appdelegate = getAppDelegate
        }
    }
    
    
    func fetchData<T>(body: T) where T : Decodable, T : Encodable {
        method = RequestType.POST
        
        if let project = body as? CreateProjectEntity{
            parameters = try? JSONEncoder().encode(project.self)
            if let _ = project.ProjectId{
                path  = ProjectApis.projectCreateUrl
            }else{
                path = ProjectApis.updateProject
            }
            sendDataToServer()
        }
        
    }
    
    func sendDataToServer(){
        let createProject:  Observable<CreateProjectResponseEntity> = Network.get(apiRequest: self)

        createProject.subscribe(onNext: { (response) in
            self.message = (response.message,response.error)
        }, onError: { (error) in
            self.presenter?.dataFetchedFailed(error: error.localizedDescription)
        }, onCompleted: {
            self.presenter?.dataFetched(news: self.message)
            self.message = (nil, nil)
        }) {
            
        }.dispose()

    }
    
    func fetchData() {
        
        let projectAssignees: Observable<AssigneResponseEntity> = Network.get(apiRequest: self)
        projectAssignees.subscribe(onNext: { (response) in
            self.assigneeList = response.data
        }, onError: { (error) in
            self.presenter?.dataFetchedFailed(error: AlertMessage.assigneeListFailed.rawValue)
        }, onCompleted: {
            self.saveProjectList()
        }) {
        }
        
    }
    
    func saveProjectList(){
        if let projectList = assigneeList{
            if let assignees = ProjectAssigneeDatabase.saveList(appdelegate: appdelegate, assigneList: projectList){
                self.presenter?.dataFetched(news: assignees)
            }else{
                 self.presenter?.dataFetchedFailed(error: AlertMessage.assigneeListFailed.rawValue)
            }
        }else{
             self.presenter?.dataFetchedFailed(error: AlertMessage.assigneeListFailed.rawValue)
        }
        
    }
    
}

