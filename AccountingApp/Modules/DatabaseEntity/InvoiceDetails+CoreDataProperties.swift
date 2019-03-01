//
//  InvoiceDetails+CoreDataProperties.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//
//

import Foundation
import CoreData


extension InvoiceDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InvoiceDetails> {
        return NSFetchRequest<InvoiceDetails>(entityName: "InvoiceDetails")
    }

    @NSManaged public var cvr: String?
    @NSManaged public var tax: String?
    @NSManaged public var amount: String?
    @NSManaged public var date: String?
    @NSManaged public var image: String?
    @NSManaged public var invoice: Invoices?

}
