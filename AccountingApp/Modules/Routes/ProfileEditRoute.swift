//
//  ProfileEditRoute.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 15/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit


class ProfileEditRoute: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        let view = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "ProfileEditController") as? ProfileEditController
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = ProfileEditPresenter()
        let interactor: PresentorToInterectorProtocol = ProfileEditInteractor()
        let router: PresenterToRouterProtocol = ProfileEditRoute()
        
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

