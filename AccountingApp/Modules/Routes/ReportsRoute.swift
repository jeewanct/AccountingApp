//
//  ReportsRoute.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit


class ReportsRoute: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        let view = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "ReportsController") as? ReportsController
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = ReportsPresenter()
        let interactor: PresentorToInterectorProtocol = ReportsInteractor()
        let router: PresenterToRouterProtocol = ReportsRoute()
        
        view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interector = interactor
        interactor.presenter = presenter
        view?.tabBarItem.title = "Reports"
        view?.tabBarItem.image = #imageLiteral(resourceName: "reportsTab")
        return view!
        
        //}
        
        //return UIViewController()
    }

}
