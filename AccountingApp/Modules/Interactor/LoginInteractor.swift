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
    var parameters: Data
    var headers: [String : String]
    var presenter: InterectorToPresenterProtocol?
    
    // Login Interactor initiliazers
    init() {
        method = RequestType.POST
        path = LoginApis.loginUrl
        parameters = Data()
        headers = path.getHeader()
        
    }
    
    func fetchData() {}
    
    func fetchData<T>(body: T) where T : Decodable, T : Encodable {
        let (data, _) = EncodeData.getData(parameters: body)
        if  let jsonData = data{
            parameters = jsonData
        }else{
            presenter?.dataFetchedFailed()
        }
        
        
    }
    
    func callServer(){
        
        let loginResponse: Observable<LoginResponseEntity> = Network.shared.post(apiRequest: self)
        
        loginResponse.subscribe(onNext: { (response) in
            print(response)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            
        }) {
            
        }
        
    }

}

// Saving user profile to Database

extension LoginInteractor{
    
    func saveUserProfile(userData: LoginData?){
        
        UserDefaults.standard.set(userData?.Token, forKey: "token")
        UserDefaults.standard.set(userData?.CompanyId, forKey: "companyId")
        UserDefaults.standard.set(userData?.ID, forKey: "userId")
        
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            
            if let userInformation = NSEntityDescription.insertNewObject(forEntityName: "Profile", into: appDelegate.persistentContainer.viewContext) as? Profile{
                
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
                    fullName.append(firstName)
                }
                
                if let firstName = userData?.LastName{
                    fullName.append(" ")
                    fullName.append(firstName)
                }
                
                userInformation.name = fullName
                
                userInformation.profileImage = userData?.ImagePath
                userInformation.email = userData?.Email
                
                appDelegate.saveContext()
                
            }
        
        }
        
        
    }
    
}
