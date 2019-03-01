//
//  GroupMessageInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 14/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation
import RxSwift
import ReusableFramework


class GroupMessageInteractor: PresentorToInterectorProtocol, APIRequest {
    
    var method: RequestType
    var path: String
    var parameters: Data?
    var headers: [String : String]
    var presenter: InterectorToPresenterProtocol?
    var groupMessage:  GroupChatModel?
    var projectId: String?
    var error: (String?, Bool?)?
   // var finalGroup = [GroupUIEntity]()
   // var lastPosition: GroupInformationEntity? // have to change
  
    
    
    init() {
        method = RequestType.GET
        path = ""
        parameters = Data()
        headers = path.getHeader()
    }


    func fetchData<T>(body: T) where T : Decodable, T : Encodable {
        
        if let getGroupType = body as? GroupInformationEntity{
             method = RequestType.GET
            projectId = getGroupType.projectId
            //lastPosition = getGroupType
            if getGroupType.type == GroupMessageType.seen.rawValue{
            
                path = GroupsControllerApi.groupChatComments + GlobalConstants.projectId + getGroupType.projectId + GlobalConstants.parentCommentId + getGroupType.parentCommentId + GlobalConstants.pageNumber + "\(getGroupType.seenOffset)" + GlobalConstants.subGroupId + getGroupType.subGroupId
                
                getChatData(type: getGroupType.type)
            
            }else{
                
                path = GroupsControllerApi.unseenGroupMessage + GlobalConstants.projectId + getGroupType.projectId + GlobalConstants.parentCommentId + getGroupType.parentCommentId + GlobalConstants.pageNumber + "\(getGroupType.seenOffset)" + GlobalConstants.subGroupId + getGroupType.subGroupId
                
                getChatData(type: getGroupType.type)
                
            }
            
            
        }
        
        
        if let groupDeleteMessage = body as? GroupMessageDeleteEntity{
            
            parameters = try? JSONEncoder().encode(groupDeleteMessage)
            deleteGroupMessage()
            
        }
        
    }
    
    func getChatData(type: String?){
        
        let groupMessageData: Observable<GroupChatModel> = Network.shared.post(apiRequest: self)
        
        groupMessageData.subscribe(onNext: { (response) in
            self.groupMessage = response
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            self.makeGroupList(type: type)
        }) {
            
        }
        
    }
    
    
    func makeGroupList(type: String?){
        
        guard let unwrappedGroupMessage = groupMessage else {
             return
        }
        
        let uiGroupMessageList = GroupUIEntity()
        
        uiGroupMessageList.type = type
        uiGroupMessageList.isMoreDataAvail = unwrappedGroupMessage.more
        uiGroupMessageList.isLoadingList = false
        if let groupMessages = unwrappedGroupMessage.data{
         
            var groupList = [GroupDetailEntity]()
            
            for message in groupMessages{
                
                let messageDetail = GroupDetailEntity()
                
                messageDetail.userName = Helper.getFullName(firstName: message.UserProfile?.FirstName, lastName: message.UserProfile?.LastName)
             
                messageDetail.commentDate = Helper.timeAgoSinceDate(Helper.convertStringToDate(date: message.CreatedTime), currentDate: Date(), numericDates: false)
                
                messageDetail.comment = message.Comment
                
               
                if let userId = message.UserProfile?.UserId{
                    let (loginUserId, _)  = UserHelper.companyID()
                    if loginUserId == String(userId){
                        messageDetail.isEditButtonEnable = true
                    }else{
                        messageDetail.isEditButtonEnable = false
                    }
                }
                
                if let getprojectId = projectId {
                     messageDetail.projectId = getprojectId
                }
                
                if let commentId = message.CommentId{
                    messageDetail.commentId = String(commentId)
                }
                
                messageDetail.userProfile = message.UserProfile?.ImageUrl
               
                if let conversationCount = message.TotalChildCount{
                    
                    if conversationCount > 0 {
                        messageDetail.startConversation = "View full conversation (\(conversationCount))"
                    }else{
                        messageDetail.startConversation = "Start conversation"
                    }
                    
                    
                }else{
                    messageDetail.startConversation = "Start conversation"
                }
                
                if let seenCount = message.seenCount{
                    if seenCount == 0{
                        
                    }else{
                         messageDetail.seenBy = "Seen by \(seenCount)"
                    }
                   
                }
                
                var imageList = [String?]()
                
                if let images = message.File{
                    
                    if images.count != 0 {
                        
                        messageDetail.isCollectionHidden = false
                        for image in images{
                            imageList.append(image.Url)
                        }
                        
                    }else{
                        messageDetail.isCollectionHidden = true
                    }
                    
                    
                }
                
                messageDetail.imagesArray = imageList
                groupList.append(messageDetail)
                
            }
            
           // if let
            
            if groupList.count == 0 {
                uiGroupMessageList.noData = false
            }else{
                uiGroupMessageList.noData = true
            }
            
            uiGroupMessageList.groupChatList  = groupList
            
        }
        
        self.presenter?.dataFetched(news: uiGroupMessageList)
        
        
    }
    
    func fetchData() {
        
    }
    
    
    func deleteGroupMessage(){
        method = RequestType.POST
        
        let deleteMessage: Observable<CreateSubGroupResponse> = Network.get(apiRequest: self)
        
        deleteMessage.subscribe(onNext: { (response) in
            self.error = (response.message, response.error)
        }, onError: { (error) in
            self.presenter?.dataFetchedFailed(error: error.localizedDescription)
        }, onCompleted: {
            self.presenter?.dataFetched(news: self.error)
            self.error = nil
        }) {
            
        }
    }
    
    
}
