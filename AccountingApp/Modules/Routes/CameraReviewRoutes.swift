//
//  CameraReviewRoutes.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 14/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit


class CameraReviewRoutes: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        let view = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "CameraReviewController") as? CameraReviewController
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = CameraReviewPresenter()
        let interactor: PresentorToInterectorProtocol = CameraReviewInteractor()
        let router: PresenterToRouterProtocol = CameraReviewRoutes()
        
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

