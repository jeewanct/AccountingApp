//
//  CameraConstants.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 19/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation

struct CameraApis{
    static let getProjectList = "/api/ProjectManagement/GetAssignUserProjectList"
    //static let uploadImages = "http://ocr.cadhla.com/v1/upload/image/"
    static let uploadImages = "https://invoice-scan.herokuapp.com/v1/upload/image"
    static let uploadInvoices = "/api/Projectmanagement/ScanInvoiceSave"
}


enum CameraEnum: String{
    
    case title = "Preview"
    case upload = "Upload"
    case select = "Select"
    
}

enum CameraErrorEnum: String{
    
    case selectProject = "Please select project to proceed."
    case selectTitle = "Please give a valid name to your bill title."
    
    
}

enum UploadInvoiceEnum: String{
    case title = "Upload Invoice"
    case uploadAiToServerCell = "UploadAiToServerCell"
}

