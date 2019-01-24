//
//  ProfileEditInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 15/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//


import UIKit
import RxSwift
import CoreData
import ReusableFramework


class ProfileEditInteractor: PresentorToInterectorProtocol, APIMultipartRequest{
    
    var headers: [String : String]
    var multiFormData: MultipartEntity
    var url: String
    
    init() {
       url = GlobalConstants.base + LoginApis.editProfile
       headers = url.getHeader()
        multiFormData = MultipartEntity(parameters: [:], imageData: [MultipartImageInfoEntity(imageData: Data(), withName: "")])
    }
    
    var editMessage = ""
    var presenter: InterectorToPresenterProtocol?

}


extension ProfileEditInteractor{
    
    func fetchData<T: Codable>(body: T) {
        
        if let editDetails = body as? EditRequestEntity{
            
            let (userId, _) = UserHelper.companyID()
            
            let parameters = [
                "UserId": userId,
                "FirstName": editDetails.firstName ?? "",
                "LastName": editDetails.lastName ?? "",
                "MobileNo": "",
                "Password": "",
                "Email": ""
            ]
            
            
            if let imageData = editDetails.image{
                let multipartImage = MultipartImageInfoEntity(imageData: imageData, withName: "files")
                
                multiFormData = MultipartEntity(parameters: parameters, imageData: [multipartImage])
                
            }else{
                multiFormData = MultipartEntity(parameters: parameters, imageData: nil)
            }
            
            callServer()
            
        }
        
    }
    
    func callServer(){
        
        
        let editProfile: Observable<EditRequestToServer> = Network.shared.multipartRequest(request: self)
        
        editProfile.subscribe(onNext: { (response) in
            
            if response.error == false{
                ProfileDatabase.saveUserProfile(userData: response.data, update: true)
            }
            
            if let message = response.message{
                self.editMessage = message
            }
        }, onError: { (error) in
            self.presenter?.dataFetchedFailed(error: error.localizedDescription)
        }, onCompleted: {
            
            if self.editMessage == "Ok"{
                self.presenter?.dataFetched(news: AlertMessage.profileEdited.rawValue)
            }else{
                self.presenter?.dataFetched(news: self.editMessage)
            }
            
            
            self.editMessage = ""
        }) {
            
        }
        
    }
    
    func fetchData() {
        
        if let profileDetails = ProfileDatabase.fetchData(){
            makeEditEntity(info: profileDetails)
        }else{
            presenter?.dataFetchedFailed(error: AlertMessage.userInfoFetchError.rawValue)
        }
        
//        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else{
//            presenter?.dataFetchedFailed(error: AlertMessage.userInfoFetchError.rawValue)
//            return
//
//        }
//
//        let userInfoRequest = NSFetchRequest<Profile>(entityName: "Profile")
//        do{
//            let userInfo = try appdelegate.persistentContainer.viewContext.fetch(userInfoRequest)
//            if userInfo.count > 0{
//                let profileDetails = userInfo[0]
//                makeEditEntity(info: profileDetails)
//            }
//
//        }catch let error{
//            presenter?.dataFetchedFailed(error: error.localizedDescription)
//        }
    }
    
    func makeEditEntity(info: Profile){
        
        
        let userInfo = [
            EditUserInfoEntity(image: #imageLiteral(resourceName: "editPlaceHolderImage"), text: info.firstName, enable: true),
            EditUserInfoEntity(image: #imageLiteral(resourceName: "editPlaceHolderImage"), text: info.lastName, enable: true),
            EditUserInfoEntity(image: #imageLiteral(resourceName: "editPlaceHolderImage"), text: info.name, enable: false),
            EditUserInfoEntity(image: #imageLiteral(resourceName: "emailImage"), text: info.email, enable: false),
            EditUserInfoEntity(image: #imageLiteral(resourceName: "mobileImage"), text: "********", enable: false),
            EditUserInfoEntity(image: #imageLiteral(resourceName: "passwordImage"), text: "********", enable: false),
            EditUserInfoEntity(image: #imageLiteral(resourceName: "passwordImage"), text: "********", enable: false)
        ]
        
        
        let editEntity = EditProfileEntity(image: info.profileImage, info: userInfo)
        
        self.presenter?.dataFetched(news: editEntity)
        
        
    }
    
}


