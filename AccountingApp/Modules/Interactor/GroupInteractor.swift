//
//  GroupInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 14/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import RxSwift
import Foundation
import ReusableFramework


class GroupInteractor: PresentorToInterectorProtocol, APIRequest{
    
    var method: RequestType
    var path: String
    var parameters: Data
    var headers: [String : String]
    
    init() {
        method = RequestType.GET
        let (_, companyId) = UserHelper.companyID()
        path =  GroupsControllerApi.groupListsUrl + companyId
        parameters = Data()
        headers = path.getHeader()
        
    
        
        
        
    }
    
    var groups = [GroupDataEntity]()
    var presenter: InterectorToPresenterProtocol?
    
    
    
}


extension GroupInteractor{
    
    func fetchData<T>(body: T) where T : Decodable, T : Encodable {  }
    
    func fetchData() {
        
        let groupList: Observable<GroupEntity> = Network.shared.get(apiRequest: self)
        
        groupList.subscribe(onNext: { (groupsList) in
            print(dump(groupList))
            if let list = groupsList.data{
                self.groups = list
            }
        }, onError: { (error) in
            self.presenter?.dataFetchedFailed(error: error.localizedDescription)
        }, onCompleted: {
            self.presenter?.dataFetched(news: self.saveToDatabase())
            //self.saveToDatabase()
        }) {
            
        }
        
    }
    
    
    func saveToDatabase() -> [GroupsEntity]{
        
        var groupData = [GroupsEntity]()
        
        for group in groups{
            
            let uiGroup = GroupsEntity()
            
            if let id = group.ProjectID{
                uiGroup.groupId = String(id)
            }
            
            uiGroup.groupName = group.ProjectName
            
            if let subGroupArray = group.SubGroup{
                
                if subGroupArray.count == 0{
                    uiGroup.numberOfSubGroups = ""
                }else{
                    uiGroup.numberOfSubGroups = "\(subGroupArray.count) " + GroupEnum.subGroup.rawValue
                }
                
                var uiSubGroups = [SubGroupDataEntity]()
                
                for subGroups in subGroupArray{
                    
                    let uiSubGroup = SubGroupDataEntity()
                    
                    uiSubGroup.subGroupName = subGroups.SubGroupName
                    
                    if let id = subGroups.SubGroupId{
                        uiSubGroup.subGroupId = String(id)
                    }
                    
                    uiSubGroups.append(uiSubGroup)
                    
                }
                
                uiGroup.subGroups = uiSubGroups
                
            }
            
            groupData.append(uiGroup)
            //self.presenter?.dataFetched(news: groupData)
            
        }
        
        return groupData
        
    }
}
