//
//  LoginRoutes.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//


import UIKit


class LoginRoute: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        let view = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "LoginController") as? LoginController
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = LoginPresenter()
        let interactor: PresentorToInterectorProtocol = LoginInteractor()
        let router: PresenterToRouterProtocol = LoginRoute()
        
        view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interector = interactor
        interactor.presenter = presenter
        
        return view!
        
    }
    
 
    
    
}
