//
//  CreateSubGroupInteracto.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 18/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//



import Foundation
import RxSwift
import ReusableFramework


class CreateSubGroupInteractor: PresentorToInterectorProtocol, APIRequest{
    var method: RequestType
    var path: String
    var parameters: Data?
    var headers: [String : String]
    var assigneeList: [AssigneDetailEntity]?
    var appdelegate: AppDelegate!
    var error: Bool?
    init() {
            method = RequestType.GET
            path =  LoginApis.getAssignIds + "/\(UserHelper.companyID().1)"
            headers = path.getHeader()
            if let getAppDelegate = UIApplication.shared.delegate as? AppDelegate{
                appdelegate = getAppDelegate
            }
        }
 
    
    var presenter: InterectorToPresenterProtocol?
    
    func fetchData<T>(body: T) where T : Decodable, T : Encodable {
        method = RequestType.POST
        path = GroupsControllerApi.createSubGroup
        if let createSubGroup = body as? SubGroupUIEntity{
            let (data, _) = EncodeData.getData(parameters: createSubGroup)
            parameters = data
            callSubgroupServer()
        }
        
    }
    
    func callSubgroupServer(){
        
        let subGroup: Observable<CreateSubGroupResponse>  = Network.get(apiRequest: self)
        
        subGroup.subscribe(onNext: { (response) in
            self.error = response.error
            print(response)
        }, onError: { (error) in
            self.presenter?.dataFetchedFailed(error: error.localizedDescription)
        }, onCompleted: {
            self.presenter?.dataFetched(news: self.error)
            self.error = nil
        }) {
            
        }
    }
    
    func fetchData() {
        method = RequestType.GET
         path =  LoginApis.getAssignIds + "/\(UserHelper.companyID().1)"
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
