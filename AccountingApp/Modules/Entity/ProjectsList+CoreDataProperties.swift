//
//  ProjectsList+CoreDataProperties.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 23/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//
//

import Foundation
import CoreData


extension ProjectsList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectsList> {
        return NSFetchRequest<ProjectsList>(entityName: "ProjectsList")
    }

    @NSManaged public var projectName: String?
    @NSManaged public var startDate: String?
    @NSManaged public var endDate: String?
    @NSManaged public var serverStartDate: String?
    @NSManaged public var serverEndDate: String?
    @NSManaged public var sortingStartDate: NSDate?
    @NSManaged public var sortingEndDate: NSDate?
    @NSManaged public var canEditProject: Bool
    @NSManaged public var createdBy: String?
    @NSManaged public var projectDatesList: NSSet?
    @NSManaged public var projectId: String?
}

// MARK: Generated accessors for projectDatesList
extension ProjectsList {

    @objc(addProjectDatesListObject:)
    @NSManaged public func addToProjectDatesList(_ value: ProjectDates)

    @objc(removeProjectDatesListObject:)
    @NSManaged public func removeFromProjectDatesList(_ value: ProjectDates)

    @objc(addProjectDatesList:)
    @NSManaged public func addToProjectDatesList(_ values: NSSet)

    @objc(removeProjectDatesList:)
    @NSManaged public func removeFromProjectDatesList(_ values: NSSet)

}
