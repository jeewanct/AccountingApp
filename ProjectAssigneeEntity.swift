//
//  ProjectAssigneeEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 09/02/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation

class AssigneResponseEntity:Decodable{
    var data: [AssigneDetailEntity]?
}

class AssigneDetailEntity: Decodable{
     var ID: Int?
     var Email: String?
     var FirstName: String?
     var LastName: String?
     var UserType: Int?
     var IsActive: Bool?
     var Deleted: String?
     var Password: String?
     var CreateDate: CLong?
    //   var ModifiedDate: CLong = 0
    //    var LastLoginDate: CLong = 0
     var ParentID: Int?
     var CreatedBy: String?
     var AssignId: String?
     var Token: String?
     var CompanyId: Int?
     var ImagePath: String?
    
}

class ProjectAssigneeEntity{
    var name: String?
    var id: String?
}
