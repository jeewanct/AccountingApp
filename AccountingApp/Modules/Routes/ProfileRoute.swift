//
//  ProfileRoute.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit


class ProfileRoute: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        
        let view = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "ProfileController") as? ProfileController

        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = ProfilePresenter()
        let interactor: PresentorToInterectorProtocol = ProfileInteractor()
        let router: PresenterToRouterProtocol = ProfileRoute()
        
        view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interector = interactor
        interactor.presenter = presenter
        view?.tabBarItem.title = "Profile"
        view?.tabBarItem.image = #imageLiteral(resourceName: "profileTab")
        return view!
        
        //}
        
        //return UIViewController()
    }
    
   
    
}
