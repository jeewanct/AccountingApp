//
//  ProjectRoute.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit


class ProjectRoute: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        let view = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "ProjectsController") as? ProjectsController
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = ProjectsPresenter()
        let interactor: PresentorToInterectorProtocol = InvoiceInteractor()
        let router: PresenterToRouterProtocol = ProjectRoute()
        
        view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interector = interactor
        interactor.presenter = presenter
        view?.tabBarItem.title = "Projects"
        view?.tabBarItem.image = #imageLiteral(resourceName: "projectTab")
        
        return view!
        
        //}
        
        //return UIViewController()
    }
    
    
    
}
