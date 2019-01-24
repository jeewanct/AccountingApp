//
//  CredentialsCheck.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 16/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation

class CredentialsCheck{
    
    // Check if login or not
    
    class func isLogin() -> Bool{
        
        return UserDefaults.standard.bool(forKey: KeysEnum.isLogin.rawValue)
        
    }
    
    // Get user Id and company Id
    
    class func usersIdAndHisCompanyId() -> (userId: String, companyId: String){
        
        if let userId = UserDefaults.standard.value(forKey: KeysEnum.userId.rawValue) as? String, let companyId = UserDefaults.standard.value(forKey: KeysEnum.companyId.rawValue) as? String{
            
            return (userId, companyId)
        }
        
        return ("", "")
    
    }
    
    
    class func isSecured() -> Bool{
        return UserDefaults.standard.bool(forKey: KeysEnum.isBiometric.rawValue)
    }
    
}
