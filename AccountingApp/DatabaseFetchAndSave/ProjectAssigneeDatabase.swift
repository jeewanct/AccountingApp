//
//  ProjectAssigneeDatabase.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 09/02/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import CoreData
import Foundation

class ProjectAssigneeDatabase{
    
    class func saveList(appdelegate: AppDelegate, assigneList: [AssigneDetailEntity])  -> [ProjectAssigneeEntity]?{
        
         ProfileDatabase.deleteData(entityName: DatabaseEntityName.assigneeList.rawValue, context: appdelegate)
        
        for assignee in assigneList{
            if let assigneeDatabase = NSEntityDescription.insertNewObject(forEntityName: DatabaseEntityName.assigneeList.rawValue, into: appdelegate.persistentContainer.viewContext) as? ProjectAssignees{
                assigneeDatabase.name = Helper.getFullName(firstName: assignee.FirstName, lastName: assignee.LastName)
                if let userId = assignee.ID{
                    assigneeDatabase.userId = String(userId)
                }
            }
        }
        appdelegate.saveContext()
        return getList(appdelegate: appdelegate)
    }
    
    class func getList(appdelegate: AppDelegate) -> [ProjectAssigneeEntity]?{
        
        let fetchRequest = NSFetchRequest<ProjectAssignees>(entityName: DatabaseEntityName.assigneeList.rawValue)
        
        do{
            let list = try appdelegate.persistentContainer.viewContext.fetch(fetchRequest)
            
            var assignees = [ProjectAssigneeEntity]()
            for assignee in list{
                let listValue = ProjectAssigneeEntity()
                listValue.id = assignee.userId
                listValue.name = assignee.name
                assignees.append(listValue)
            }
            return assignees
        }catch  _{
        }
        return nil
        
    }
    
}
