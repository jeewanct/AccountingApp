//
//  GroupApis.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 17/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation


struct GroupsControllerApi{
    
    static let groupListsUrl = "/api/ProjectManagement/GetProjectList?companyId="
    static let groupChatComments = "/api/ProjectManagement/GetGroupComment"
    static let createGroupMessage =  "/api/ProjectManagement/CreateGroupMessage"
    static let deleteConversation = "/api/ProjectManagement/DeleteComment"
    static let getConversationSeen = "/api/ProjectManagement/GetCommentSeen"
    static let setSeenBy = "/api/ProjectManagement/SetCommentSeen"
    static let getSeenBy = "/api/ProjectManagement/GetCommentSeen"
    static let updateConversation = "/api/ProjectManagement/UpdateComment"
    static let createSubGroup = "/api/ProjectManagement/CreateSubGroup"
    static let unseenGroupMessage = "/api/ProjectManagement/GetUnSeenGroupComment"
    
}
