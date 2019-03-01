//
//  GroupChatInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 15/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation
import RxSwift
import ReusableFramework

class GroupChatInteractor: PresentorToInterectorProtocol, APIRequest, APIMultipartRequest{
    var multiFormData: MultipartEntity
    var url: String
    var method: RequestType
    var path: String
    var parameters: Data?
    var headers: [String : String]
    var groupMessage:  GroupChatModel?
    var currentIndex = 1
    var error: (String?, Bool?)?
    
    init() {
        method = RequestType.GET
        path = ""
        headers = path.getHeader()
        url = ""
        multiFormData = MultipartEntity(parameters: [:], imageData: nil)
    }
    
    var presenter: InterectorToPresenterProtocol?
    
    func fetchData<T>(body: T){
        method = RequestType.GET
        if let groupChatData = body as? GroupChatEntity{
            currentIndex  = groupChatData.currentIndex
            
            if let projectId = groupChatData.message?.projectId, let parentCommentId = groupChatData.message?.commentId{
                 path =  GroupsControllerApi.groupChatComments + "?projectId=\(projectId)&parentCommentId=\(parentCommentId)&pageNo=\(groupChatData.currentIndex)&SubGroupID=\(0)"
                getReplyChats()
            }
            
        }
        
        if let converstation = body as? CreateConversationEntity{
            method = RequestType.POST
            if converstation.type == ConversationType.create.rawValue{
                url  = GlobalConstants.base + GroupsControllerApi.createGroupMessage
            }else{
                url = GlobalConstants.base + GroupsControllerApi.updateConversation
            }
            
            let conversationParameter = [
                "UserId" : converstation.userId ?? "",
                "Comment" : converstation.comment ?? "",
                "CompanyId" : converstation.companyId ?? "",
                "ProjectId" : converstation.projectId ?? "",
                "ParentCommentId" : converstation.parentCommentId ?? "",
                "CommentType" :  "1"
            ]
            
            if let imageData = converstation.imageData{
                
                var multiImagesArray = [ MultipartImageInfoEntity]()
                
                for image in imageData{
                    multiImagesArray.append(MultipartImageInfoEntity(imageData: image, withName: "file"))
                }
                multiFormData = MultipartEntity(parameters: conversationParameter, imageData: multiImagesArray)
                
            }else{
                multiFormData = MultipartEntity(parameters: conversationParameter, imageData: nil)
            }
            
            callCreateConversationServer()
            
            
        }
        
    }
    
    func getReplyChats(){
        
       let groupChatData: Observable<GroupChatModel> = Network.shared.post(apiRequest: self)
        
        groupChatData.subscribe(onNext: { (response) in
            self.groupMessage = response
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            self.makeGroupList()
        }) {
            
        }
        
    }
    
    
    func makeGroupList(){
        
        guard let unwrappedGroupMessage = groupMessage else {
            return
        }
        
        let uiGroupMessageList = GroupResponseEntity()
        
       // uiGroupMessageList.type = type
        uiGroupMessageList.isMoreDataAvail = unwrappedGroupMessage.more
        uiGroupMessageList.index = currentIndex //+ 1
        if let groupMessages = unwrappedGroupMessage.data{
            
            var groupList = [GroupDetailEntity]()
            
            for message in groupMessages{
                
                let messageDetail = GroupDetailEntity()
                
                messageDetail.userName = Helper.getFullName(firstName: message.UserProfile?.FirstName, lastName: message.UserProfile?.LastName)
                
                messageDetail.commentDate = Helper.timeAgoSinceDate(Helper.convertStringToDate(date: message.CreatedTime), currentDate: Date(), numericDates: false)
                
                messageDetail.comment = message.Comment
                
                messageDetail.userProfile = message.UserProfile?.ImageUrl
                
                if let userId = message.UserProfile?.UserId{
                    let (loginUserId, _)  = UserHelper.companyID()
                    if loginUserId == String(userId){
                        messageDetail.isEditButtonEnable = true
                    }else{
                        messageDetail.isEditButtonEnable = false
                    }
                }
                
                
                if let conversationCount = message.ChildComment?.count{
                    
                    if conversationCount > 0 {
                        messageDetail.startConversation = "View full conversation (\(conversationCount))"
                    }else{
                        messageDetail.startConversation = "Start conversation"
                    }
                    
                    
                }else{
                    messageDetail.startConversation = "Start conversation"
                }
                
                if let seenCount = message.seenCount{
                    messageDetail.seenBy = "Seen by \(seenCount)"
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
            
//            if groupList.count == 0 {
//                uiGroupMessageList.noData = false
//            }else{
//                uiGroupMessageList.noData = true
//            }
            
            uiGroupMessageList.messages  = groupList
           // let finalValue = (currentIndex + 1, groupList )
            
            self.presenter?.dataFetched(news: uiGroupMessageList)
            
        }
        
    }
    
    func fetchData() {
        
    }
    
    func getDataFromServer(url: String, data: Data){
      
        
    }
    
    func callCreateConversationServer(){
        
        let createConversation: Observable<NewConversationModel> = Network.shared.multipartRequest(request: self)
        
        createConversation.subscribe(onNext: { (response) in
            print(response)
            self.error = (response.message, response.error)
        }, onError: { (error) in
            self.presenter?.dataFetchedFailed(error: error.localizedDescription)
        }, onCompleted: {
           // if let errorCode = self.error{
                self.presenter?.dataFetched(news: self.error)
           // }
            self.error = nil
            
        }) {
            
        }
        
        
    }

    
}

