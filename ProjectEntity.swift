//
//  ProjectEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 21/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit


// Project Controller

class PojectEntity{
    
    var isCreateProjectHidden: Bool?
    var projectList: [ProjectsEntity]?
    var currentDisplayDate: [ProjectDateEntity]?
    var currentDisplayTask: [ProjectTaskEntity]?
    var noTaskShown: Bool?
    
}

class ProjectsEntity{
    
    var projectId: String?
    var projectName: String?
    var startDate: String?
    var endDate: String?
    var createdBy: String?
    var canEdit: Bool?
    var sort: Date?
    var dates: [ProjectDateEntity]?
    var assigneeList: String?
    var serverStartDate: Date?
    var serverEndDate: Date?
    var projectBudget: String?
    
    
}

class ProjectDateEntity{
    var day: String?
    var date: String?
    var taskList: [ProjectTaskEntity]?
}

class ProjectTaskEntity{
    
    var taskAndHours: String?
    var taskDescription: String?
    var taskId: String?
    var projectId: String?
    var hours: String?
    var minute: String?
    var taskName: String?
    var editTaskName: String?
    var createdDate: Date?
    
}

class ProjectDate: Codable{
    var startDate: CLong
    var endDate: CLong
    
    init(startDate: CLong, endDate: CLong){
        self.startDate = startDate
        self.endDate = endDate
    }
}




// Server Decodable Entity

class ProjectListApiModel: Decodable{
    
    var message: String?
    var error: Bool?
    var data : [ProjectListModel]?
    var code: String?
}

class ProjectListModel: Decodable{
    var ProjectID : Int?
    var ProjectName: String?
    var StartDate: CLong?
    var EndDate: CLong?
    var ProjectAssignTo: String?
    var ProjectBudGet: String?
    var ModifiedDate: CLong?
    var CreatedByName: String?
    //var CreateDate: String?
    var Status: Bool?
    var UserID: Int?
    var CompanyId: Int?
    var Description: String?
    var taskDates: [ProjectTaskDateListModel]?
    var projectTasks:[ProjectTaskDateListModel]?
}


class ProjectTaskApiModel: Decodable{
    var message: String?
    var error: Bool?
    var data : [ProjectTaskDateListModel]?
    
}


class ProjectTaskDateListModel: Decodable{
    var TaskDate: CLong?
    var Task: [ProjectTaskModel]?
}

class ProjectTaskModel: Decodable{
    
    
    var TaskDate: CLong?
    var ProjectId: Int?
    var TaskText: String?
    var Hours: Int?
    var Minutes: Int?
    var Description: String?
    var CreateDate: CLong?
    var ModifieDate: CLong?
    var UserId: Int?
    var CompanyId: Int?
    var TaskId: Int?
    
}



class CreateProjectDataModel: Codable{
    
    var ProjectId: String?
    var UserId: String?
    var CompanyId: String?
    var CreatedByName: String?
    var StartDate: String?
    var EndDate: String?
    var ProjectAssignTo: String?
    var ProjectName: String?
    var ProjectBudGet: String?
    
    init() {
        
        let (userId, companyId) = UserHelper.companyID()
        self.UserId = userId
        self.CompanyId = companyId
    
    }
    
}


// Delete task

class ProjectTaskDelete: Codable{
    var TaskId: String?
    var UserId: String?
    init(taskId: String?) {
        TaskId = taskId
        UserId = CredentialsCheck.usersIdAndHisCompanyId().1
    }
}
