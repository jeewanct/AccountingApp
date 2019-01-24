//
//  CameraReviewInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 14/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation
import RxSwift
import CoreData
import ReusableFramework


class CameraReviewInteractor: PresentorToInterectorProtocol, APIRequest{
    
    var method: RequestType
    var path: String
    var parameters: Data
    var headers: [String : String]
    var appdelegate: AppDelegate
    var projectList: [CameraProjectListEntity]?
    
    
    init() {
        
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
    
    var presenter: InterectorToPresenterProtocol?
    
}


extension CameraReviewInteractor{
    func fetchData<T>(body: T) where T : Decodable, T : Encodable {
        
    
    }
    
    func fetchData() {
        
        let projectList: Observable<CameraProjectEntity> = Network.shared.get(apiRequest: self)
        
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
