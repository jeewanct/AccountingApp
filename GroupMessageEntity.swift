//
//  GroupMessageEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 29/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation

enum GroupMessageType: String{
    case seen = "seen"
    case unseen = "unseen"
}

enum GroupType: String{
    case group = "group"
    case subGroup = "subGroup"
}

class GroupInformationEntity: Codable{
    
    var projectName: String?
    var parentCommentId: String = "0"
    var subGroupId: String = "0"
    var projectId: String
    var seenOffset: Int = 1
    var unseenOffset: Int = 1
    var type = GroupMessageType.unseen.rawValue
    var groupType: String
    
    init(projectId: String, parentCommentId: String = "0", subGroupId: String = "0", groupType: String, projectName: String?) {
        self.projectId = projectId
        self.parentCommentId = parentCommentId
        self.subGroupId = subGroupId
        self.groupType = groupType
        self.projectName = projectName
    }
    
    
}


class GroupUIEntity{
    
    var isMoreDataAvail: Bool?
    var isLoadingList: Bool?
    var type: String?
    var groupChatList: [GroupDetailEntity]?
    var noData = false
    
}


// DeleteEntity

class GroupMessageDeleteEntity: Codable{
    
    var ParentCommentId: String?
    var ProjectId: String?
    var SubGroupId: String?
    
    init(projectId: String?, subGroupId: String?, commentId: String?) {
        self.ProjectId = projectId
        self.SubGroupId = subGroupId
        self.ParentCommentId = commentId
    }
    
}

class GroupDetailEntity: Codable{
    
    var userProfile: String?
    var userName: String?
    var commentDate: String?
    var comment: String?
    var commentId: String?
    var projectId: String?
    var isCollectionHidden: Bool?
    var imagesArray: [String?]?
    var seenBy: String?
    var startConversation: String?
    var isEditButtonEnable: Bool = true
    var taggedPerson: String?
}


// Get Messages List

class GroupChatModel: Decodable{
    
    var data: [GroupChatDataModel]?
    var status: Bool?
    // var code: String?
    var message: String?
    var error: Bool?
    var more: Bool?
}

class GroupChatDataModel: Decodable{
    var GroupId: Int?
    var CommentId: Int?
    var Comment : String?
    var UserProfile: UserProfileModel?
    var CreatedTime: CLong?
    var File: [UserProfileFileModel]?
    var ParentCommentId: Int?
    var ProjectId: Int?
    var TotalChildCount: Int?
    var ChildComment: [GroupChatDataModel]?
    //var isMoreDataAvailable: String?
    var seenBy: [UserCommentSeenModel]?
    var seenCount: Int?
    var LoggedUserSeen: Bool?
    var cellType: String?
    var TaggedUser: String?
    //var tempImageUse: [UIImage]?
    
}


class UserProfileModel: Decodable{
    var UserId: Int?
    var ImageUrl: String?
    var CreatedDate: CLong?
    var FirstName: String?
    var LastName: String?
    
}

class UserProfileFileModel: Decodable{
    
    var Url: String?
    var FileType: String?
    
}

class UserCommentSeenModel: Decodable{
    //   var UserId: String?
    var ImageUrl: String?
    var FirstName: String?
    var LastName: String?
    var CreatedDate: CLong?
}


//Delete entity

class UserMessageDeleteEntity: Codable{
    var ParentCommentId: String?
    
    init(commentId: String?){
        ParentCommentId = commentId
    }
}


// Group Seen

class GroupMessageSeen: Codable{
    var SubGroupId: String?
    var CommentId: String?
    var CommentType = "0"
    var UserId : String?
    var ProjectId: String?
    
    init(subGroupId: String?, commentId: String?) {
        let (userId, _) = CredentialsCheck.usersIdAndHisCompanyId()
        self.UserId = userId
        SubGroupId = subGroupId
        CommentId = commentId
    }
}
