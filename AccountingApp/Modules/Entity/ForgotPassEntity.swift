//
//  ForgotPassEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import Foundation

class ForgotSendEntity: Codable{
    
    var Email: String?
    
    init(email: String?) {
        self.Email = email
    }
    
}

class ForgotResponseEntity: Decodable{
    var error: Bool?
    var message: String?
}
