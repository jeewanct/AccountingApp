//
//  InvoiceEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import Foundation


class InvoiceEntity{
    var scannedInvoices: [InvoiceDetailEntity]
    var unscannedInvoices: [InvoiceDetailEntity]
    init(scanned: [InvoiceDetailEntity], unscanned: [InvoiceDetailEntity]) {
        self.scannedInvoices = scanned
        self.unscannedInvoices = unscanned
    }
}

class InvoiceDetailEntity{
    var date: String?
    var detail: String?
    var cost: String?
    var invoiceDescription: [InvoiceDescription]?
    
    init(date: String?, detail: String?, cost: String?,invoiceDescription:  [InvoiceDescription]?) {
        self.date = date
        self.detail = detail
        self.cost = cost
        self.invoiceDescription = invoiceDescription
    }
}

class InvoiceDescription{
    
    var cvr: String?
    var tax: String?
    var amount: String?
    var date: String?
    var image: String?
    
    init(cvr: String?, tax: String?, amount: String?, date: String?, image: String?) {
        self.cvr = cvr
        self.tax = tax
        self.amount = amount
        self.date = date
        self.image = image
        
    }
    
}

class InvoiceResponseEntity: Decodable{
    var error: Bool?
    var data: [InvoiceModel]?
    var code: String?
    var message: String?
    
}

class InvoiceModel: Decodable{
    var billTitle: String?
    var companyId: Int?
    var createdDate: CLong?
    var  fileDetails: [InvoiceDataImageModel]?
    var projectId: Int?
    var totalAmount: Float?
    var userId: Int?
    var invoiceDetails: [InvoiceDetailModel]?
}

class InvoiceDetailModel: Decodable{
    var cvr: String?
    var tax_amount: Float?
    var   total_amount: Float?
    var  date: String?
}
class InvoiceDataImageModel:  Decodable{
    var imagename: String?
    var imagepath: String?
}


class InvoiceData{
    var scannedInvoice: [Invoices]?
    var pendingInvoice: [Invoices]?
}
