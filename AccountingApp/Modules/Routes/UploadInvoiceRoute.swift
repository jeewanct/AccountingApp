//
//  UploadInvoiceRoute.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 21/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit


class UploadInvoiceRoute: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        let view = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "UploadInvoiceController") as? UploadInvoiceController
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = UploadInvoicePresenter()
        let interactor: PresentorToInterectorProtocol = UploadInvoiceInteractor()
        let router: PresenterToRouterProtocol = UploadInvoiceRoute()
        
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
