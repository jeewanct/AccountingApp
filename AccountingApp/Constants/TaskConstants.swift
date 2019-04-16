//
//  TaskConstants.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 02/03/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation

enum TaskConstants: String{
    case selectProject = "Select Project"
    case taskDate = "DD/MM/YY"
    case selectHours = "Select hrs"
    case selectMins = "Select Mins"
    case editTask = "Edit Task"
    case createTask = "Create Task"
    
}

enum TaskAlerts: String{
    case selectProject = "Select Project cannot be empty."
    case taskDate = "Task date cannot be empty."
    case selectMins = "Selected Hours and minutes cannot be zero."
    case task = "Task name cannot be empty."
    case description = "Description field cannot be empty."

}
