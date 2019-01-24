//
//  CameraEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 18/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class CameraEntity{
    
    var billTitle: String
    var cameraDetail: [CameraDetailEntity]
    
    init(title: String, detail: [CameraDetailEntity]) {
        self.billTitle = title
        self.cameraDetail = detail
    }
    
}

class CameraDetailEntity{
    
    var imageArray: String
    var totalAmount: String
    var date: String
    var cvr: String
    
    init(images: String, totalAmount: String, date: String, cvr: String) {
        self.imageArray = images
        self.totalAmount = totalAmount
        self.date = date
        self.cvr = cvr
    }
}


class CameraImages{
    
    var name: String
    var image: UIImage
    var date: String?
    var cvr: String?
    var amount: String?
    
    init(image: UIImage) {
        name = UUID().uuidString
        self.image = image
    }
    
    
}
