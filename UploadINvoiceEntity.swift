//
//  UploadINvoiceEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 17/03/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation

class UploadInvoiceEntity: Codable{
    var imageData: [Data]?
    var invoiceDetails: [MultiAiModel]?
    var userId: String?
    var projectId: String?
    var companyId: String?
    var billTitle: String?
    
    init(projectId: String?, billTitle: String?, image: [Data]?) {
        let (userId, companyId) = CredentialsCheck.usersIdAndHisCompanyId()
        self.userId = userId
        self.companyId = companyId
        self.projectId = projectId
        self.billTitle = billTitle
        self.imageData = image
    }
    
}
