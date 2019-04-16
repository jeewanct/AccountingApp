//
//  TaskInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 19/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation
import ReusableFramework
import RxSwift

class TaskInteractor: PresentorToInterectorProtocol, APIRequest{
    var method: RequestType
    var path: String
    var parameters: Data?
    var headers: [String : String]
    var presenter: InterectorToPresenterProtocol?
    var appdelegate: AppDelegate
    var projectList: [CameraProjectListEntity]?
    var message: (String?, Bool?)
    
    init(){
        method = RequestType.GET
        let (userId, companyId) = UserHelper.companyID()
        path = ProjectApis.getProjectList + ProjectApis.userId + "\(userId)" + ProjectApis.companyId + "\(companyId)"
        parameters = Data()
        headers = path.getHeader()
        appdelegate = AppDelegate()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            appdelegate = appDelegate
        }
        
    }
    
    
    func fetchData<T>(body: T) where T : Decodable, T : Encodable {
    
        method = RequestType.POST
        
        if let project = body as? TaskCreateEntity{
            parameters = try? JSONEncoder().encode(project.self)
            if CreateProjectTypeEnum.create.rawValue == project.type{
                path  = ProjectApis.addTaskUrl
            }else{
                path = ProjectApis.updateTask
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
            
        }
        
    }
    
    func fetchData() {
        
        method = RequestType.GET
        let (userId, companyId) = UserHelper.companyID()
        path = ProjectApis.getProjectList + ProjectApis.userId + "\(userId)" + ProjectApis.companyId + "\(companyId)"
        let projectList: Observable<CameraProjectEntity> = Network.get(apiRequest: self)
        
        projectList.subscribe(onNext: { (response) in
            self.projectList = response.data
        }, onError: { (error) in
            self.saveProjectList()
        }, onCompleted: {
            self.saveProjectList()
        }) {
            
        }
        
    }
    
    func saveProjectList(){
        
        if let list = projectList{
            let allProjectList = CamerReviewDatabase.saveToDatabase(appdelegate: appdelegate, projectLists: list)
            self.presenter?.dataFetched(news: allProjectList)
        }else{
            self.presenter?.dataFetchedFailed(error: AlertMessage.projectListFetchFailed.rawValue)
        }
        
    }
    
}

