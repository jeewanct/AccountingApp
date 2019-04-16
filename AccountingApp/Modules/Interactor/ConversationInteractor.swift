//
//  ConversationInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 16/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation
import RxSwift
import ReusableFramework


class ConversationInteractor: PresentorToInterectorProtocol, APIMultipartRequest{
    
    var multiFormData: MultipartEntity
    var url: String
    var headers: [String : String]
    var presenter: InterectorToPresenterProtocol?
    var error: Bool?
    
    init(){
        url = ""
        headers = url.mulitpartHeader()
        multiFormData = MultipartEntity(parameters: [:], imageData: nil)
        
  //MultipartImageInfoEntity
    }
    
    func fetchData<T: Encodable>(body: T) {
        
        if let converstation = body as? CreateConversationEntity{
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
                "ParentCommentId" : "0",
                "CommentType" :  "0",
                "SubGroupID" : converstation.subGroupId  ?? "0"
            ]
            
            if let imageData = converstation.imageData{
                
                var multiImagesArray = [MultipartImageInfoEntity]()
                
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
    
    func callCreateConversationServer(){
        
        let createConversation: Observable<NewConversationModel> = Network.shared.multipartRequest(request: self)
        
        createConversation.subscribe(onNext: { (response) in
            print(response)
            self.error = response.error
        }, onError: { (error) in
            self.presenter?.dataFetchedFailed(error: error.localizedDescription)
        }, onCompleted: {
            if let errorCode = self.error{
                self.presenter?.dataFetched(news: errorCode)
            }
            self.error = nil
        }) {
            
        }
        
        
    }
    
    
    func fetchData() {
        
    }
    
    func getDataFromServer(url: String, data: Data){
        //        Networking.shared.postRequest(url: url, header: url.getHeader(), data: data, completion: { (forgotPass: ForgotResponseEntity) in
        //
        //            self.presenter?.dataFetched(news: forgotPass)
        //
        //        }) { (error) in
        //            self.presenter?.dataFetchedFailed()
        //        }
        
    }
    
}
