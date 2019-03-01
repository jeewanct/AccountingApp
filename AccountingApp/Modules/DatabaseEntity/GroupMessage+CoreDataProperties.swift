//
//  GroupMessage+CoreDataProperties.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 29/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//
//

import Foundation
import CoreData


extension GroupMessage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupMessage> {
        return NSFetchRequest<GroupMessage>(entityName: "GroupMessage")
    }

    @NSManaged public var userName: String?
    @NSManaged public var commentDate: String?
    @NSManaged public var userId: String?
    @NSManaged public var comment: String?
    @NSManaged public var seenBy: String?
    @NSManaged public var conversation: String?
    @NSManaged public var commentImage: [String]?

}
