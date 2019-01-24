//
//  Invoices+CoreDataProperties.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//
//

import Foundation
import CoreData


extension Invoices {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Invoices> {
        return NSFetchRequest<Invoices>(entityName: "Invoices")
    }

    @NSManaged public var id: String?
    @NSManaged public var date: String?
    @NSManaged public var detail: String?
    @NSManaged public var cost: String?
    @NSManaged public var createdDate: Date?
    @NSManaged public var invoiceId: String?
    @NSManaged public var invoiceDetail: NSSet?
    
}

// MARK: Generated accessors for invoiceDetail

extension Invoices {

    @objc(addInvoiceDetailObject:)
    @NSManaged public func addToInvoiceDetail(_ value: InvoiceDetails)

    @objc(removeInvoiceDetailObject:)
    @NSManaged public func removeFromInvoiceDetail(_ value: InvoiceDetails)

    @objc(addInvoiceDetail:)
    @NSManaged public func addToInvoiceDetail(_ values: NSSet)

    @objc(removeInvoiceDetail:)
    @NSManaged public func removeFromInvoiceDetail(_ values: NSSet)

}
