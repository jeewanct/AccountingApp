//
//  ProjectList+CoreDataProperties.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//
//

import Foundation
import CoreData


extension ProjectList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectList> {
        return NSFetchRequest<ProjectList>(entityName: "ProjectList")
    }

    @NSManaged public var projectId: String?
    @NSManaged public var projectName: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    
}
