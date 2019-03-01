//
//  CreateConversationEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 14/02/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation

enum ConversationType: String{
    case update =  "update"
    case create = "create"
}
class CreateConversationEntity: Codable{
    
    var type: String?
    var projectId: String?
    var subGroupId: String?
    var companyId: String?
    var userId: String?
    var comment: String?
    var imageData: [Data]?
    var parentCommentId: String?
    var commentType = "0"
    var imagePath: [String?]?
    
    
    init(type: String){
        let (userId, companyId)  = UserHelper.companyID()
        self.userId = userId
        self.companyId = companyId
        self.parentCommentId = "0"
        self.type = type
    }
    init(projectId: String?, subGroupId: String?,  comment: String? , type: String, parentComentId: String?) {
        self.projectId = projectId
        self.subGroupId = subGroupId
        self.comment = comment
      //  self.imageData = imageData
        self.type = type
        
        let (userId, companyId)  = UserHelper.companyID()
        self.userId = userId
        self.companyId = companyId
        self.parentCommentId = parentComentId
        
    }
    
}


class NewConversationModel: Decodable{
    var error: Bool?
    var message: String?
    var status: Bool?
   
}
