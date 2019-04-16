//
//  GroupConstants.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 17/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation


enum GroupEnum: String{
    
    case subGroup = "Sub Group"
}

enum GroupMessageEnum: String{
    
    case createSubGroup = "Create Subgroup"
    case warning = "Warning"
    case title = "Choose an option to modify/delete message."
    case delete = "Delete"
    case edit = "Edit"
    case cancel = "Cancel"
    
}


enum CreateConversationEnum: String{
    case startConversation = "Share something in the group..."
    case emptyFields = "No input from user, please add comment or image to create conversation."
    case conversationFailed = "Something went wrong"
    case conversationCreated = "Conversation created successfully."
}

enum CreateSubGroupEnum: String{
    case groupName = "Subgroup name is required!"
    case members = "Please add members."
    case subGroupError = "Cannot create subgroup at this moment."
    case subGroupCreated = "Subgroup created."
    case ok = "Ok"
    case createSubgroup = "CREATE SUBGROUP"
}

enum CreateReplyEnum: String{
    case replyTo = "Replying to "
    case delete = "Delete chat"
    case ok = "Ok"
    case cancel = "Cancel"
}
