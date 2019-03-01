//
//  GroupChatEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 12/02/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class GroupChatEntity: Codable{
    
    var isMoreDataAvail = true
    var currentIndex = 1
    var message: GroupDetailEntity?
    var replies: [GroupDetailEntity]?

}

class GroupResponseEntity{
    
    var isMoreDataAvail: Bool?
    var index = 1
    var messages: [GroupDetailEntity]?
}


class GroupChatRequestEntity: Codable{
    
    var UserId: String?
    var comment: String?
    var CompanyId: String?
    var ProjectId: String?
    var ParentCommentId: String?
    var CommentType: String? = ""
    var images: [Data]?
    
    init(projectId: String? = "", parentCommentId: String? = "") {
        let (userId, companyId) = UserHelper.companyID()
        UserId = userId
        CompanyId = companyId
        ProjectId = projectId
        ParentCommentId = parentCommentId
    }
}
