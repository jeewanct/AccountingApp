//
//  CameraReviewDatabase.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import CoreData
import Foundation

class CamerReviewDatabase {
    
    class func saveToDatabase(appdelegate: AppDelegate, projectLists: [CameraProjectListEntity]) -> [CameraProjectUIEntity]?{
        
        ProfileDatabase.deleteData(entityName: "ProjectList", context: appdelegate)
        
        for project in projectLists{
            
            if let projectEntity = NSEntityDescription.insertNewObject(forEntityName: "ProjectList", into: appdelegate.persistentContainer.viewContext) as? ProjectList{
                
                projectEntity.projectName = project.ProjectName
                if let projectId = project.ProjectID{
                    projectEntity.projectId = String(projectId)
                }
                
            }
            
        }
        
        appdelegate.saveContext()
        
       return getProjectList(appdelegate: appdelegate)
        
    }
    
    
    class func getProjectList(appdelegate: AppDelegate) -> [CameraProjectUIEntity]?{
        
        let projectList = NSFetchRequest<ProjectList>(entityName: "ProjectList")
        
        do{
            
            let results = try appdelegate.persistentContainer.viewContext.fetch(projectList)
            
            var projectsList = [CameraProjectUIEntity]()
            
            for result in results{
                projectsList.append(CameraProjectUIEntity(projectName: result.projectName, id: result.projectId))
            }
            
            return projectsList
            
        }catch _{
            
        }
        
        
        
        return nil
    }
    
}
