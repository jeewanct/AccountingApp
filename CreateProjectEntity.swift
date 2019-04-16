//
//  CreateProjectEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 09/02/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation

class CreateProjectEntity: Codable{
    
    var type: String?
    var ProjectId: String?
    var UserId: String?
    var CompanyId: String?
    var CreatedByName: String?
    var StartDate: String?
    var EndDate: String?
    var ProjectAssignTo: String?
    var ProjectName: String?
    var ProjectBudGet: String?
    var serverStartDate: Date?
    var serverEndDate: Date?

    init(projectId: String?, createdBy: String?, type: String) {
        self.ProjectId = projectId
        let (userId, companyId) = UserHelper.companyID()
        self.UserId = userId
        self.CompanyId = companyId
        self.CreatedByName = createdBy
        if createdBy == ""{
            self.CreatedByName = UserDefaults.standard.string(forKey: KeysEnum.userName.rawValue)
        }else{
            self.CreatedByName = createdBy
        }
        
        self.type = type
    }
    
}


class CreateProjectResponseEntity: Decodable{
    var error: Bool?
    var message: String?
    var status: Bool?
}
