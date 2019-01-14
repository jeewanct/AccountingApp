//
//  InvoiceRoute.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

class InvoiceRoute: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "InvoiceController") as? InvoiceController
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = InvoicePresenter()
        let interactor: PresentorToInterectorProtocol = InvoiceInteractor()
        let router: PresenterToRouterProtocol = InvoiceRoute()
        
        view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interector = interactor
        interactor.presenter = presenter
        view?.tabBarItem.title = "Invoice"
        view?.tabBarItem.image = #imageLiteral(resourceName: "InvoiceTab")
        
        return view!

    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    
}
