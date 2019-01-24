//
//  CreateProjectRoute.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 19/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit


class CreateProjectRoute: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        let view = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "CreateProjectController") as? CreateProjectController
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = CreateProjectPresenter()
        let interactor: PresentorToInterectorProtocol = CreateProjectInteractor()
        let router: PresenterToRouterProtocol = CreateProjectRoute()
        
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


