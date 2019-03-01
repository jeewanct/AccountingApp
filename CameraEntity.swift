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
    
    var imageArray: Data
    var totalAmount: String?
    var date: [String]?
    var cvr: [String]?
    var tax: String?
    
    init(images: Data, totalAmount: String, date: [String]?, cvr: [String]?, tax: String?) {
        self.imageArray = images
        self.totalAmount = totalAmount
        self.date = date
        self.cvr = cvr
        self.tax = tax
    }
}

class MultiAiModel: Decodable{
    
    var cvr: [String?]?
    var total_amount: Float?
    var date: [String?]?
    var tax: String?
}


class CameraImages{
    
    var name: String
    var image: UIImage
    var imageData: Data
    init(image: UIImage) {
        name = UUID().uuidString
        self.image = image
        self.imageData = image.jpegData(compressionQuality: 0) ?? Data()
        
    }
    
    
}
