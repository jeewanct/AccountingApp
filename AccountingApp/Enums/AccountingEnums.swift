//
//  AccountingEnums.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import Foundation


enum ErrorCodeEnum: String{
    case logout = "401"
    case noImagesFound = "No image found!"
}


enum ProjectNibs: String{
    case imagePreviewCell = "ImagePreviewCell"
}

enum AlertMessage: String{
    
    case empty = "All fields are required"
    case email = "Input email is not valid"
    case logout = "Log out of "
    case ok = "Ok"
    case cancel = "Cancel"
    case userInfoFetchError = "Could not fetch user information"
    case profileEdited = "Profile edited Succesfully"
    case fetchError = "Cannot fetch invoices from database"
    case sessionExpired = "Session Expired! Log out of "
    case projectListFetchFailed = "Project List cannot be fetch at this time"
    case startDateIsGreaterThanendDate = "Start date cannot be greater than end date."
    case assigneeListFailed = "Could'nt fetch Assignee list"
    
    
}

enum KeysEnum: String{
    case isLogin = "isLogin"
    case userId = "userId"
    case companyId = "companyId"
    case token = "token"
    case userName = "userName"
    case isBiometric = "isBiometric"
    case userType = "userType"
}



