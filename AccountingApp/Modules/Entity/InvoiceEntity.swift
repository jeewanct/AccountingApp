//
//  InvoiceEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import Foundation


class InvoiceResponseEntity: Decodable{
    var error: Bool?
    var data: [InvoiceModel]?
    var code: String?
    
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
