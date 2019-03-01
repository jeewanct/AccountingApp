//
//  ProjectDatabase.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 22/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import CoreData
import Foundation


class ProjectDatabase{
    
    class func saveProjects(projects: [ProjectListModel], appdelegate: AppDelegate) -> PojectEntity?{
        
        ProfileDatabase.deleteData(entityName: "Projects", context: appdelegate)
        
        if let projectEntity = NSEntityDescription.insertNewObject(forEntityName: "Projects", into: appdelegate.persistentContainer.viewContext) as? Projects{
            
            if UserHelper.userType() == "1" || UserHelper.userType() == "2"{
                projectEntity.canCreateProject = true
            }else{
                projectEntity.canCreateProject = false
            }
            
            for project in projects{
                
                if let projectType = NSEntityDescription.insertNewObject(forEntityName: "ProjectsList", into: appdelegate.persistentContainer.viewContext ) as? ProjectsList{
                    
                    
                    projectType.projectName = project.ProjectName
                    projectType.sortingStartDate = Helper.convertStringToDate(date: project.StartDate) as? NSDate
                    projectType.sortingStartDate = Helper.convertStringToDate(date: project.EndDate) as? NSDate
                    
                    projectType.createdBy = project.CreatedByName
                    
                    projectType.startDate = Helper.getProjectStartingDate(date: Helper.convertStringToDate(date: project.StartDate))
                    projectType.endDate = Helper.getProjectStartingDate(date: Helper.convertStringToDate(date: project.EndDate))
                    
                    if let projectId = project.ProjectID{
                        projectType.projectId = String(projectId)
                    }
                    
                    
                    if UserHelper.userType() == "1" || UserHelper.userType() == "2"{
                        projectType.canEditProject = true
                    }else {
                        if let userId = project.UserID{
                            
                            let (id, _) = CredentialsCheck.usersIdAndHisCompanyId()
                            if String(userId) == id{
                                projectType.canEditProject = true
                            }else{
                                projectType.canEditProject = false
                            }
                            
                        }
                    }
                    
                    if let endDate = project.EndDate{
                        projectType.serverEndDate = String(endDate)
                    }
                    
                    if let startDate = project.StartDate{
                        projectType.serverStartDate = String(startDate)
                    }
                  
                
                    projectEntity.addToProjectLists(projectType)
                    
                    if let projectDates = project.projectTasks{

                        for date in projectDates{

                        if let projectDatabaseDate = NSEntityDescription.insertNewObject(forEntityName: "ProjectDates", into: appdelegate.persistentContainer.viewContext) as? ProjectDates{
                            let (dayName, dateName) = Helper.projectDayDate(date: date.TaskDate)
                            projectDatabaseDate.projectDate = dateName
                            projectDatabaseDate.projectDay = dayName

                            if let projectTasks = date.Task{
                                for task in projectTasks{

                                    if let projectDatabaseTask = NSEntityDescription.insertNewObject(forEntityName: "ProjectTasks", into: appdelegate.persistentContainer.viewContext) as? ProjectTasks{
                                        if let taskId = task.TaskId{
                                            projectDatabaseTask.taskId = String(taskId)
                                        }

                                        if let projectId = task.ProjectId{
                                            projectDatabaseTask.taskProjectId = String(projectId)
                                        }

                                        projectDatabaseTask.taskName = task.TaskText
                                        projectDatabaseTask.taskDescription = task.Description
                                        projectDatabaseDate.addToProjectTaskList(projectDatabaseTask)
                                    }



                                }
                            }

                           projectType.addToProjectDatesList(projectDatabaseDate)

                        }

                        }

                    }
                    
                    projectEntity.addToProjectLists(projectType)
                    
                }
                
            }
            
            appdelegate.saveContext()
            
        }
        
        return getProjectsFromDatabase(appdelegate: appdelegate)
        
        
    }
    
    class func getProjectsFromDatabase(appdelegate: AppDelegate) -> PojectEntity?{
        
        let fetchRequest = NSFetchRequest<Projects>(entityName: "Projects")
       
        do{
            let projects = try appdelegate.persistentContainer.viewContext.fetch(fetchRequest)
            
            if projects.count > 0{
                
                let projectFromDb = projects[0]
                
                let projectEntity = PojectEntity()
                projectEntity.isCreateProjectHidden = projectFromDb.canCreateProject
                var projectArray = [ProjectsEntity]()
                    
                if let projectList = projectFromDb.projectLists {
                    
                    for list in projectList{
                        
                        let projectDetails = ProjectsEntity()
                        if let savingList = list as? ProjectsList{
                            projectDetails.canEdit = savingList.canEditProject
                            projectDetails.createdBy = savingList.createdBy
                            projectDetails.startDate = savingList.startDate
                            projectDetails.endDate = savingList.endDate
                            projectDetails.projectId = savingList.projectId
                            projectDetails.projectName = savingList.projectName
                            projectDetails.sort = savingList.sortingStartDate as Date?
                            if let projectDates = savingList.projectDatesList{
                                
                                var projectDateArray = [ProjectDateEntity]()
                                
                                for dates in projectDates{
                                    if let date = dates as? ProjectDates{
                                        let projectDateModel = ProjectDateEntity()
                                        projectDateModel.date = date.projectDate
                                        projectDateModel.day = date.projectDay
                                        
                                        if let projectTasks = date.projectTaskList{
                                            
                                            
                                            var projectTaskArray = [ProjectTaskEntity]()
                                            for task in projectTasks{
                                                
                                                if let getTask = task as? ProjectTasks{
                                                    let projectTaskEntity = ProjectTaskEntity()
                                                    
                                                    projectTaskEntity.taskDescription = getTask.taskDescription
                                                    projectTaskEntity.taskAndHours = getTask.taskName
                                                    projectTaskEntity.taskId = getTask.taskId
                                                    projectTaskEntity.projectId = getTask.taskProjectId
                                                    
                                                    projectTaskArray.append(projectTaskEntity)
                                                    
                                                }
                                            }
                                            projectDateModel.taskList = projectTaskArray
                                            
                                        }
                                        projectDateArray.append(projectDateModel)
                                        
                                    }
                                    
                                }
                                
                               
                                
                                projectDetails.dates = projectDateArray
                                
                                
                            }
                            
                            
                            projectArray.append(projectDetails)
                            
                        }
                        
                        

                    }
                    
                }
                
                projectArray.sort { (value1, value2) -> Bool in
                    if value1.sort! > value2.sort!{
                        return true
                    }
                    return false
                }
                
                projectEntity.projectList = projectArray
                
                
                if let firstProject = projectArray.first{
                    
                    projectEntity.currentDisplayDate = firstProject.dates
                    
                    if let firstDate = firstProject.dates?.first?.taskList{
                        projectEntity.currentDisplayTask = firstDate
                    }
                    
                    
                }
                
                return projectEntity
                
            }
            
        }catch _{
            
        }
        
        return nil
        
    }
    
    
}
