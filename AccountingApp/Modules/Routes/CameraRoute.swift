//
//  CameraRoute.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit


class CameraRoute: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        let view = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "CameraController") as? CameraController
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = CameraPresenter()
        let interactor: PresentorToInterectorProtocol = CameraInteractor()
        let router: PresenterToRouterProtocol = CameraRoute()
        
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
