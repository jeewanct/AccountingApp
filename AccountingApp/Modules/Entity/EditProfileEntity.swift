//
//  EditProfileEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 18/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class EditRequestEntity: Codable{
    
    var image: Data?
    var firstName: String?
    var lastName: String?
    
}

class EditRequestToServer: Decodable{
    var message: String?
    var error: Bool?
    var data : LoginData?
}

class EditProfileEntity{
    
    var userImage: String?
    var userInfo: [EditUserInfoEntity]
    var updateButtonEntity = EditUpdateEntity()
    
    init(image: String?, info: [EditUserInfoEntity]) {
        userImage = image
        userInfo = info
    }
    
}

class EditUserInfoEntity{
    
    var placeHolderImage: UIImage
    var placeHolderText: String?
    var isEnable: Bool
    
    init(image: UIImage, text: String?, enable: Bool) {
        placeHolderImage = image
        placeHolderText = text
        isEnable = enable
    }
    
}


class EditUpdateEntity{
    
    var tag = 0
    var isAnimating = false
    
}
