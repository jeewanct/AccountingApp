//
//  AllProjectsRoutes.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 14/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit


class AllProjectsRoutes: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        let view = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "AllProjectsController") as? AllProjectsController
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = AllProjectsPresenter()
        let interactor: PresentorToInterectorProtocol = AllProjectsInteractor()
        let router: PresenterToRouterProtocol = AllProjectsRoutes()
        
        view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interector = interactor
        interactor.presenter = presenter
        
        return view!
        
        //}
        
        //return UIViewController()
    }
    
    
    
}
