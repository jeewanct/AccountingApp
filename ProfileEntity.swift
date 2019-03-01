//
//  ProfileEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 16/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class ProfileLogoutResponseEntity: Codable{
    
    var error: Bool?
    var message: String?
    
}


class ProfileEntity{
    
    var imageUrl: String
    var name: String?
    var imageUrlLocal: UIImage
    var profileOptions: [ProfileOptionEntity]?
    
    
    init(image: String, name: String?, localImage: UIImage, profileOption : [ProfileOptionEntity]?) {
        self.imageUrl = image
        self.name = name
        self.imageUrlLocal = localImage
        self.profileOptions = profileOption
    }
    
}

class ProfileOptionEntity{
    var groupName: String?
    var image: UIImage?
    
    init(groupName: String? , image: UIImage) {
        
        self.groupName = groupName
        self.image = image
    }
    
}
