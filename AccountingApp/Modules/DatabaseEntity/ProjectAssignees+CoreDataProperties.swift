//
//  ProjectAssignees+CoreDataProperties.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 09/02/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//
//

import Foundation
import CoreData


extension ProjectAssignees {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectAssignees> {
        return NSFetchRequest<ProjectAssignees>(entityName: "ProjectAssignees")
    }

    @NSManaged public var name: String?
    @NSManaged public var userId: String?

}
