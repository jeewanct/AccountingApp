//
//  CameraConstants.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 19/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation

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

