//
//  Projects+CoreDataProperties.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 23/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//
//

import Foundation
import CoreData


extension Projects {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Projects> {
        return NSFetchRequest<Projects>(entityName: "Projects")
    }

    @NSManaged public var canCreateProject: Bool
    @NSManaged public var noTaskLabelShown: Bool
    @NSManaged public var projectLists: NSSet?

}

// MARK: Generated accessors for projectLists
extension Projects {

    @objc(addProjectListsObject:)
    @NSManaged public func addToProjectLists(_ value: ProjectsList)

    @objc(removeProjectListsObject:)
    @NSManaged public func removeFromProjectLists(_ value: ProjectsList)

    @objc(addProjectLists:)
    @NSManaged public func addToProjectLists(_ values: NSSet)

    @objc(removeProjectLists:)
    @NSManaged public func removeFromProjectLists(_ values: NSSet)

}
