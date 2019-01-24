//
//  ChangeRootViewController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 17/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

enum ChangeToControllerEnum {
    
    case LoginController
    case HomeController
    
}


class ChangeRootViewController{
    
    class func changeRootViewController(to controller: ChangeToControllerEnum){
        
        var viewController = UIViewController()
        
        switch controller {
        case .HomeController:
           
            viewController = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "HomeController")
        default:
            viewController = LoginRoute.createModule()
        }
        
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate{
            
            appdelegate.window?.rootViewController = viewController
        }
        
    }
    
}
