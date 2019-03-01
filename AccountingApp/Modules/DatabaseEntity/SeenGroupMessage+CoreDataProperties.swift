//
//  SeenGroupMessage+CoreDataProperties.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 29/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//
//

import Foundation
import CoreData


extension SeenGroupMessage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SeenGroupMessage> {
        return NSFetchRequest<SeenGroupMessage>(entityName: "SeenGroupMessage")
    }

    @NSManaged public var isMoreDataAvailable: Bool
    @NSManaged public var groupMessage: NSSet?

}

// MARK: Generated accessors for groupMessage
extension SeenGroupMessage {

    @objc(addGroupMessageObject:)
    @NSManaged public func addToGroupMessage(_ value: GroupMessage)

    @objc(removeGroupMessageObject:)
    @NSManaged public func removeFromGroupMessage(_ value: GroupMessage)

    @objc(addGroupMessage:)
    @NSManaged public func addToGroupMessage(_ values: NSSet)

    @objc(removeGroupMessage:)
    @NSManaged public func removeFromGroupMessage(_ values: NSSet)

}
