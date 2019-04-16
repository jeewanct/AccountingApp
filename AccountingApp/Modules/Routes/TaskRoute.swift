//
//  TaskRoute.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 19/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit


class TaskRoute: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        let view = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "TaskController") as? TaskController
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = TaskPresenter()
        let interactor: PresentorToInterectorProtocol = TaskInteractor()
        let router: PresenterToRouterProtocol = TaskRoute()
        
        view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interector = interactor
        interactor.presenter = presenter
        
        return view!
     
    }
    
}

