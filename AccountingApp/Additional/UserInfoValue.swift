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
        
        if let userId = UserDefaults.standard.value(forKey: "userId") as? Int, let companyId = UserDefaults.standard.value(forKey: "companyId") as? Int{
            
            return (String(userId), String(companyId))
        }
        
        return ("", "")
        
    }
    
}
