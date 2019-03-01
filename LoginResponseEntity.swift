//
//  LoginResponseEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import Foundation

class LoginRequestEntity: Codable{
    var Email: String?
    var Password: String?
    
    init(email: String?, password: String?) {
        self.Email = email
        self.Password = password
    }
}


class LoginResponseEntity: Decodable{
    var message: String?
    var error: Bool?
    var data : LoginResultsModel?
}

class LoginResultsModel: Codable{
    var result: LoginData?
}

class LoginData: Codable{
    var ID: Int?
    var Email: String?
    var FirstName: String?
    var LastName: String?
    var UserType: Int?
    var IsActive: Bool?
    var Deleted: String?
    var Password: String?
    var CreateDate: CLong?
    var ModifiedDate: CLong?
    var LastLoginDate: CLong?
    var ParentID: Int?
    var CreatedBy: String?
    var AssignId: String?
    var Token: String?
    var CompanyId: Int?
    var ImagePath: String?
}
