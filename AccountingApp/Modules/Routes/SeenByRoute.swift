//
//  SeenByRoute.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 04/03/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit


class SeenByRoute: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        let view = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "SeenByController") as? SeenByController
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = SeenByPresenter()
        let interactor: PresentorToInterectorProtocol = SeenByInteractor()
        let router: PresenterToRouterProtocol = SeenByRoute()
        
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

