//
//  ForgotPassRoute.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit


class ForgotPassRoute: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        let view = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "ForgotPassController") as? ForgotPassController
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = ForgotPassPresenter()
        let interactor: PresentorToInterectorProtocol = ForgotPassInteractor()
        let router: PresenterToRouterProtocol = ForgotPassRoute()
        
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

