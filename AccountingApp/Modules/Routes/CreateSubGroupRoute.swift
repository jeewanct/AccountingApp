//
//  CreateSubGroupRoute.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 18/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit


class CreateSubGroupRoute: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        let view = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "CreateSubGrouController") as? CreateSubGrouController
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = CreateSubGroupPresenter()
        let interactor: PresentorToInterectorProtocol = CreateSubGroupInteractor()
        let router: PresenterToRouterProtocol = CreateSubGroupRoute()
        
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
