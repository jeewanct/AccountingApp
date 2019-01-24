//
//  ProjectTasks+CoreDataProperties.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 23/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//
//

import Foundation
import CoreData


extension ProjectTasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectTasks> {
        return NSFetchRequest<ProjectTasks>(entityName: "ProjectTasks")
    }

    @NSManaged public var taskName: String?
    @NSManaged public var taskDescription: String?
    @NSManaged public var taskId: String?
    @NSManaged public var taskProjectId: String?

}
