//
//  SubGroupEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 16/02/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation

class SubGroupUIEntity: Codable{
    
    var groupName: String? = ""
    var SubGroupName: String? = ""
    var GroupId: String?
    var UserId: String?
    var SubGroupDescription: String? = ""
    var SubGroupMember: String? = ""
    //var subGroupMember: [String?: String?]?
    
    init(groupId: String?, groupName: String?) {
        self.GroupId = groupId
        let (userId, _ ) = UserHelper.companyID()
        self.UserId = userId
        self.groupName = groupName
    }
    
}
