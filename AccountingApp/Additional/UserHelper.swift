//
//  UserInfoValue.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class UserHelper{
    
    class func companyID() -> (String, String){
        
        if let userId = UserDefaults.standard.value(forKey: KeysEnum.userId.rawValue) as? String, let companyId = UserDefaults.standard.value(forKey: KeysEnum.companyId.rawValue) as? String{
            
            return (userId, companyId)
        }
        
        return ("", "")
        
    }
    
    class func nameOfUser() -> String{
        
        if let user = UserDefaults.standard.value(forKey: KeysEnum.userName.rawValue) as? String {
            return user
        }
        
        return ""
    }
    
    
    class func userType() -> String{
        if let userType = UserDefaults.standard.value(forKey: KeysEnum.userType.rawValue) as? String{
            return userType
            
        }
        return ""
    }
    
    class func deleteCredentials(){
        
        let bundleName = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: bundleName)
        
    }
    
    class func logoutUser(){
        let bundleName = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: bundleName)
       // ProfileDatabase.deleteData(entityName: <#T##String#>)
        
    }
    
    
    
}
