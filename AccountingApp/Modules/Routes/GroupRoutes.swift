//
//  GroupRoutes.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 14/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit


class GroupRoutes: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        let view = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "GroupController") as? GroupController
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = GroupPresenter()
        let interactor: PresentorToInterectorProtocol = GroupInteractor()
        let router: PresenterToRouterProtocol = GroupRoutes()
        
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

