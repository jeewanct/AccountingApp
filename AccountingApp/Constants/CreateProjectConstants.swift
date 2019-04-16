//
//  CreateProjectEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 09/02/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation

enum CreateProjectAlerts: String{

    case projectName = "Please mention project name."
    case startDate = "Please mention start date."
    case endDate = "Please mention end date."
    case assignee = "Please mention assigne's."
    case budget = "Please mention budget price."
    
    
}

enum CreateProjectContants: String{
    
    case startDate = "DD/MM/YY"
    case assigne = "Select"
    case createProject = "CREATE PROJECT"
    case okAction = "Ok"
    case editProject = "EDIT PROJECT"
    

}
