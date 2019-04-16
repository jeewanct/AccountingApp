//
//  CameraReviewEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 19/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation

class CameraReviewEntity: Codable{
    
    var billTitle: String?
    var images: [CameraInvoiceEntity]?
    
}

class CameraInvoiceEntity: Codable{
    var image: Data?
    var totalAmount: String?
    var date: [String?]?
    var cvr: [String?]?
    var tax: String?
}



class CameraProjectUIEntity{
    var name: String?
    var projectId: String?
    var startDate: Date?
    var endDate: Date?
    
    init(projectName: String?, id: String?, startDate: Date?, endDate: Date?) {
        name = projectName
        projectId = id
        self.startDate = startDate
        self.endDate = endDate
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
