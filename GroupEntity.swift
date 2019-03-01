//
//  GroupEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 17/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation


class GroupsEntity{
    
    var groupId: String?
    var groupName: String?
    var numberOfSubGroups: String?
    var subGroups: [SubGroupDataEntity]?
    
}

class SubGroupDataEntity{
    var subGroupName: String?
    var subGroupId: String?
}






class GroupEntity: Decodable{

    var data: [GroupDataEntity]?
    var status: Bool?
    var code: String?
    var message: String?
    var error: Bool?
}

class GroupDataEntity: Codable{
    var ProjectID: Int?
    var ProjectName: String?
    var StartDate: CLong?
    var EndDate: CLong?
    var ProjectAssignTo: String?
    var ProjectBudGet: String?
    var ModifiedDate: CLong?
    var Status: Bool?
    var UserID: Int?
    var CompanyId: Int?
    var Description: String?
    var CreatedByName: String?
    var CreateDate: CLong?
    var SubGroup: [SubGroupEntity]?
}

class SubGroupEntity: Codable{

    var CreateDate : CLong?
    var GroupId : Int?
    var ModifiedDate : CLong?
    var SubGroupDescription : String?
    var SubGroupId : Int?
    var SubGroupMembers : String?
    var SubGroupName : String?
    var UserId : Int?
    var status : Bool?

}
