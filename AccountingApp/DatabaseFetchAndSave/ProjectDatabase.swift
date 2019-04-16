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
        
        if let projectEntity = NSEntityDescription.insertNewObject(forEntityName: "Projects", into: appdelegate.updateContext) as? Projects{
            
            if UserHelper.userType() == "1" || UserHelper.userType() == "2"{
                projectEntity.canCreateProject = true
            }else{
                projectEntity.canCreateProject = false
            }
            
            for project in projects{
                
                if let projectType = NSEntityDescription.insertNewObject(forEntityName: "ProjectsList", into: appdelegate.updateContext ) as? ProjectsList{
                    
                    projectType.projectName = project.ProjectName
                    projectType.sortingStartDate = Helper.convertStringToDate(date: project.StartDate)
                    projectType.sortingEndDate = Helper.convertStringToDate(date: project.EndDate)
                    
                    projectType.projectBudget = project.ProjectBudGet
                    projectType.assigneeName = project.ProjectAssignTo
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

                        if let projectDatabaseDate = NSEntityDescription.insertNewObject(forEntityName: "ProjectDates", into: appdelegate.updateContext) as? ProjectDates{
                            let (dayName, dateName) = Helper.projectDayDate(date: date.TaskDate)
                            projectDatabaseDate.projectDate = dateName
                            projectDatabaseDate.projectDay = dayName
                            projectDatabaseDate.serverDate = String((date.TaskDate ?? 0))
                            if let projectTasks = date.Task{
                                for task in projectTasks{

                                    if let projectDatabaseTask = NSEntityDescription.insertNewObject(forEntityName: "ProjectTasks", into: appdelegate.updateContext) as? ProjectTasks{
                                        
                                        if let taskId = task.TaskId{
                                            projectDatabaseTask.taskId = String(taskId)
                                        }

                                        if let projectId = task.ProjectId{
                                            projectDatabaseTask.taskProjectId = String(projectId)
                                        }
                                        
                                        projectDatabaseTask.taskDate = Helper.convertStringToDate(date: task.CreateDate)
                                        var taskName = ""
                                        if let name = task.TaskText{
                                            taskName = name
                                        }
                                        
                                        projectDatabaseTask.editTaskName = task.TaskText
                                        
                                        projectDatabaseTask.taskDescription = task.Description
                                        var hour = ""
                                        if let hours = task.Hours{
                                               projectDatabaseTask.hours = String(hours)
                                            hour = String(hours)
                                        }else{
                                             projectDatabaseTask.hours = "0"
                                             hour = "0"
                                        }
                                        var min = ""
                                        if let minutes = task.Minutes {
                                            projectDatabaseTask.minutes = String(minutes)
                                            min = String(minutes)
                                        }else{
                                             projectDatabaseTask.hours = "0"
                                            min = "0"
                                        }
                                        projectDatabaseTask.taskName = "\(taskName)(\(hour)hrs,\(min)mins)"
                                        projectDatabaseTask.projectStartDate = projectType.sortingStartDate as Date?
                                        projectDatabaseTask.projectEndDate = projectType.sortingEndDate as Date?
                                      
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
//        let sortedDescription = NSSortDescriptor(key: #keyPath(ProjectList.startDate), ascending: false)
//        fetchRequest.sortDescriptors = [sortedDescription]
        do{
            let projects = try appdelegate.updateContext.fetch(fetchRequest)
            
            if projects.count > 0{
                
                let projectFromDb = projects[0]
                
                let projectEntity = PojectEntity()
                projectEntity.isCreateProjectHidden = projectFromDb.canCreateProject
                var projectArray = [ProjectsEntity]()
                
                
                if let projectList = projectFromDb.projectLists {
                    
                    var convertedProjectList = [ProjectsList]()
                    
                    for list in projectList{
                        if let savingList = list as? ProjectsList{
                            convertedProjectList.append(savingList)
                        }
                    }
                    
                    let sortedArrray = convertedProjectList.sorted { (value1, value2) -> Bool in
                        if (value1.sortingStartDate ??  Date()) > (value2.sortingStartDate ?? Date()){
                            return true
                        }
                        return false
                    }
                    
                    
                    for savingList in sortedArrray{
                        
                        let projectDetails = ProjectsEntity()
                       // if let savingList = list as? ProjectsList{
                            
                            projectDetails.serverStartDate = savingList.sortingStartDate as Date?
                            projectDetails.serverEndDate = savingList.sortingEndDate as Date?
                            projectDetails.projectBudget = savingList.projectBudget
                            projectDetails.assigneeList = savingList.assigneeName
                            projectDetails.canEdit = savingList.canEditProject
                            projectDetails.createdBy = savingList.createdBy
                            projectDetails.startDate = savingList.startDate
                            projectDetails.endDate = savingList.endDate
                            projectDetails.projectId = savingList.projectId
                            projectDetails.projectName = savingList.projectName
                            
                            projectDetails.sort = savingList.sortingStartDate as Date?
                        
                            if let projectDates = savingList.projectDatesList{
                                
                                var projectDateArray = [ProjectDateEntity]()
                                
                                var convertedprojectDateArray = [ProjectDates]()
                                
                                for list in projectDates{
                                    if let savingList = list as? ProjectDates{
                                        convertedprojectDateArray.append(savingList)
                                    }
                                }
                                
                                let sortedDateArrray = convertedprojectDateArray.sorted { (value1, value2) -> Bool in
                                    if (Int(value1.serverDate ?? "0") ??  0) < (Int(value2.serverDate ?? "0") ??  0){
                                        return true
                                    }
                                    return false
                                }
                                
                                for date in sortedDateArrray{
                                   // if let date = dates as? ProjectDates{
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
                                                    projectTaskEntity.hours = getTask.hours
                                                    projectTaskEntity.minute = getTask.minutes
                                                    projectTaskEntity.editTaskName = getTask.editTaskName
                                                    projectTaskEntity.createdDate = getTask.taskDate
                                                    
                                                    projectTaskEntity.hours = getTask.hours
                                                    projectTaskEntity.minute = getTask.minutes
                                                    projectTaskArray.append(projectTaskEntity)
                                                    
                                                }
                                            }
                                            projectDateModel.taskList = projectTaskArray
                                            
                                        }
                                        
                                        
                                        projectDateArray.append(projectDateModel)
                                        
                                    //}
                                    
                                }
                                
                                projectDetails.dates = projectDateArray
                            }
                            projectArray.append(projectDetails)
                            
                       // }
                    }
                }
                
//                projectArray.sort { (value1, value2) -> Bool in
//                    if value1.sort! > value2.sort!{
//                        return true
//                    }
//                    return false
//                }
                
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
