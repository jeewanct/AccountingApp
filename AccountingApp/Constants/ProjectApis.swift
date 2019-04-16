//
//  ProjectApis.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 19/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation
struct ProjectApis{
    
    let (userId, companyId) = UserHelper.companyID()
    
    static let userId = "?UserId="
    static let companyId = "&companyId="
    
    
    static let getProjectList = "/api/ProjectManagement/GetAssignUserProjectList"
    static let projectUrl = "/api/ProjectManagement/GetProjectListForMobile"
    static let projectTaskUrl = "/api/ProjectManagement/GetTaskByDateRange"
    static let projectCreateUrl = "/api/ProjectManagement/AddNewProject"
    static let updateProject = "/api/ProjectManagement/UpdatesProject"
    static let viewAllProject = "/api/ProjectManagement/SearchProject"
    static let deleteTask = "/api/ProjectManagement/DeleteTask"
    static let projectById = "/api/ProjectManagement/GetProjectById"
    static let addTaskUrl = "/api/ProjectManagement/AddNewTask"
    static let updateTask = "/api/ProjectManagement/UpdateTask"
    
}

enum ProjectEnum: String{
    
    case Tasktitle = "Task"
    case createProjectTitle = "Create Project"
    case editProjectTitle = "Edit Project"
    case okAction = "Ok"
    case cancelAction = "Cancel"
    
}

enum ProjectAlerts: String{
    case delete = "You are deleting task "
    
}
