//
//  LoginInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import ReusableFramework
import RxSwift
import Foundation
import CoreData
import UIKit

class LoginInteractor: PresentorToInterectorProtocol, APIRequest{
    
    // Request Type
    
    var method: RequestType
    var path: String
    var parameters: Data?
    var headers: [String : String]
    var presenter: InterectorToPresenterProtocol?
    var appDelegate: AppDelegate!
    var error = ""
    // Login Interactor initiliazers
    init() {
        method = RequestType.POST
        path = LoginApis.loginUrl
        parameters = Data()
        headers = path.getHeader()
        if let appDelegateInstance = UIApplication.shared.delegate as? AppDelegate{
            appDelegate = appDelegateInstance
        }
    }
    
    func fetchData() {}
    
    func fetchData<T>(body: T) where T : Decodable, T : Encodable {
        
        let (data, _) = EncodeData.getData(parameters: body)
        
        if let requestData = data{
            
            parameters = requestData
            
            let loginResponse: Observable<LoginResponseEntity> = Network.shared.post(apiRequest: self)
            
            loginResponse.subscribe(onNext: { (response) in
                
                if response.error == true{
                    if let errorMessage = response.message{
                        self.error  = errorMessage
                    }
                }else{
                    if let loginResponse = response.data?.result{
                        ProfileDatabase.saveUserProfile(userData: loginResponse, update: false)
                    }
                }
                
            }, onError: { (error) in
                self.presenter?.dataFetchedFailed(error: error.localizedDescription)
            }, onCompleted: {
                
                if self.error == ""{
                     self.presenter?.dataFetched(news: "")
                    
                }else{
                    self.presenter?.dataFetchedFailed(error: self.error)
                    self.error = ""
                }
               
            }) {
                
            }
            
            
        }else{
            self.presenter?.dataFetchedFailed(error: NetworkError.parsingError)
        }
        
        
    }
    
    

}

// Saving user profile to Database

extension LoginInteractor{
    
    func saveUserProfile(userData: LoginData?){
        
        if let token = userData?.Token, let companyId
            = userData?.CompanyId, let userId = userData?.ID, let userType = userData?.UserType{
            
            UserDefaults.standard.set(true, forKey: KeysEnum.isLogin.rawValue)
            UserDefaults.standard.set(token, forKey: KeysEnum.token.rawValue)
            UserDefaults.standard.set(String(companyId), forKey: KeysEnum.companyId.rawValue)
            UserDefaults.standard.set(String(userId), forKey: KeysEnum.userId.rawValue)
            UserDefaults.standard.set(String(userType), forKey: KeysEnum.userType.rawValue)
            
        }
        
        
           // if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
                ProfileDatabase.deleteData(entityName: "Profile", context: appDelegate)
                if let userInformation = NSEntityDescription.insertNewObject(forEntityName: "Profile", into: appDelegate.updateContext) as? Profile{
                    
                    if let userId = userData?.ID{
                        userInformation.userId = String(userId)
                    }
                    
                    if let companyId = userData?.CompanyId{
                        userInformation.companyId = String(companyId)
                    }
                    
                    if let userType = userData?.UserType{
                        userInformation.userType = String(userType)
                    }
                    
                    var fullName = ""
                    
                    if let firstName = userData?.FirstName{
                        fullName.append(firstName.capitalized)
                        userInformation.firstName = firstName
                    }
                    
                    if let lastName = userData?.LastName{
                        fullName.append(" ")
                        fullName.append(lastName.capitalized)
                        userInformation.lastName = lastName
                    }
                    
                    UserDefaults.standard.setValue(fullName, forKey: KeysEnum.userName.rawValue)
                    
                    userInformation.name = fullName
                    
                    userInformation.profileImage = userData?.ImagePath
                    userInformation.email = userData?.Email
                    
                    appDelegate.saveContext()
                    
                }
                
           // }
      
    }
    
}
