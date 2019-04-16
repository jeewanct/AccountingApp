//
//  TaskEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 02/03/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation

enum TaskPopEnum{
    case hours
    case minutes
    case projects
}
class TaskUIEntity{
    
   // var selectedDate: Date?
    var hours: [String]?
    var minutes: [String]?
    var type: TaskPopEnum?
    var projectList: [CameraProjectUIEntity]?
    
    init() {
        var finalHours = [String]()
        var finalMinutes = [String]()
        
        for index in 0...12{
            finalHours.append(String(index))
        }
        for index in 0...60{
            finalMinutes.append(String(index))
        }
        hours = finalHours
        minutes = finalMinutes
    }
    
    
}


class TaskCreateEntity: Codable{
    var type: String?
    var ProjectId: String?
    var TaskId: String?
    var Tasks: String?
    var Hours: String?
    var Minutes: String?
    var Description: String?
    var CreateDate: String?
    var UserId: String?
    var CompanyId: String?
    var serverStartDate: Date?
    var serverEndDate: Date?
    var selectedDate: Date?
    var projectName: String?
    init(projectId: String?, type: String) {
        self.ProjectId = projectId
        let (userId, companyId) = UserHelper.companyID()
        self.UserId = userId
        self.CompanyId = companyId
        self.type = type
    }
}
