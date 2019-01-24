//
//  ProjectDates+CoreDataProperties.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 23/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//
//

import Foundation
import CoreData


extension ProjectDates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectDates> {
        return NSFetchRequest<ProjectDates>(entityName: "ProjectDates")
    }

    @NSManaged public var projectDate: String?
    @NSManaged public var projectDay: String?
    @NSManaged public var serverDate: String?
    @NSManaged public var projectTaskList: NSSet?

}

// MARK: Generated accessors for projectTaskList
extension ProjectDates {

    @objc(addProjectTaskListObject:)
    @NSManaged public func addToProjectTaskList(_ value: ProjectTasks)

    @objc(removeProjectTaskListObject:)
    @NSManaged public func removeFromProjectTaskList(_ value: ProjectTasks)

    @objc(addProjectTaskList:)
    @NSManaged public func addToProjectTaskList(_ values: NSSet)

    @objc(removeProjectTaskList:)
    @NSManaged public func removeFromProjectTaskList(_ values: NSSet)

}
