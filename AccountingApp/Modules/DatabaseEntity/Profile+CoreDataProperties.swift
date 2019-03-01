//
//  Profile+CoreDataProperties.swift
//  
//
//  Created by JEEVAN TIWARI on 20/12/18.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var name: String?
    @NSManaged public var profileImage: String?
    @NSManaged public var userId: String?
    @NSManaged public var companyId: String?
    @NSManaged public var email: String?
    @NSManaged public var userType: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
}
