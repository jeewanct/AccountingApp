//
//  CameraReviewEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 19/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation

class CameraProjectUIEntity{
    var name: String?
    var projectId: String?
    
    init(projectName: String?, id: String?) {
        name = projectName
        projectId = id
    }

}

class CameraProjectEntity: Decodable{
    
      var  data:                        [CameraProjectListEntity]?
    
}

class CameraProjectListEntity: Decodable{
    
      var  ProjectID :                  Int?
      var  ProjectName:                 String?
      var  StartDate:                   CLong?
      var  EndDate:                     CLong?
      var  ProjectAssignTo:             String?
      var  ProjectBudGet:               String?
      var  ModifiedDate:                CLong?
      var  CreatedByName:               String?
      var  Status:                      Bool?
      var  UserID:                      Int?
      var  CompanyId:                   Int?
      var  Description:                 String?
}
