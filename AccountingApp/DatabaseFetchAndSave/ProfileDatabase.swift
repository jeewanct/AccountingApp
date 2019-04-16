//
//  ProfileDatabase.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit
import CoreData

class ProfileDatabase{
    
    class func saveUserProfile(userData: LoginData?, update: Bool){
        
        
        if let token = userData?.Token, let companyId
            = userData?.CompanyId, let userId = userData?.ID, let userType = userData?.UserType{
            
//            UserDefaults.standard.set(true, forKey: KeysEnum.isLogin.rawValue)
//            UserDefaults.standard.set(token, forKey: KeysEnum.token.rawValue)
//            UserDefaults.standard.set(String(companyId), forKey: KeysEnum.companyId.rawValue)
//            UserDefaults.standard.set(String(userId), forKey: KeysEnum.userId.rawValue)
            UserDefaults.standard.set(true, forKey: KeysEnum.isLogin.rawValue)
            UserDefaults.standard.set(token, forKey: KeysEnum.token.rawValue)
            UserDefaults.standard.set(String(companyId), forKey: KeysEnum.companyId.rawValue)
            UserDefaults.standard.set(String(userId), forKey: KeysEnum.userId.rawValue)
            UserDefaults.standard.set(String(userType), forKey: KeysEnum.userType.rawValue)
            
        }
        
        DispatchQueue.main.async {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
                
                func saveToDatabase(userInformation: Profile){
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
                
                if update == false{
                if let userInformation = NSEntityDescription.insertNewObject(forEntityName: "Profile", into: appDelegate.persistentContainer.viewContext) as? Profile{
                
                    saveToDatabase(userInformation: userInformation)
                }
                }else{
                    
                    if let profileInformation = fetchData(){
                        saveToDatabase(userInformation: profileInformation)
                    }
                    
                }
                
            }
        }
          
    }
    
    
    class func fetchData() -> Profile? {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        
        let userInfoRequest = NSFetchRequest<Profile>(entityName: "Profile")
        do{
            let userInfo = try appdelegate.persistentContainer.viewContext.fetch(userInfoRequest)
            if userInfo.count > 0{
                let profileDetails = userInfo[0]
                return profileDetails
            }
            
        }catch let error{
            return nil
        }
        return nil
    }
    
    class func deleteData(entityName: String, context: AppDelegate){
        
            let userInfoRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
         let deleteRequest = NSBatchDeleteRequest(fetchRequest: userInfoRequest)
            userInfoRequest.returnsObjectsAsFaults = false
            do{
                try context.updateContext.execute(deleteRequest)
                 context.saveContext()
                let userInfo = try context.updateContext.fetch(userInfoRequest)

                //userInfo.removeAll()
                for info in userInfo{
                    guard let objectData = info as? NSManagedObject else {continue}
                    //context.cacheContext.delete(objectData)
                    context.updateContext.delete(objectData)
                }
                context.saveContext()
            }catch let error{
                
            }
           
      //  }
        
    }
}
