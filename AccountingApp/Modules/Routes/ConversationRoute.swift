//
//  ConversationRoute.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 16/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit


class ConversationRoute: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        let view = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "ConversationController") as? ConversationController
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = ConversationPresenter()
        let interactor: PresentorToInterectorProtocol = ConversationInteractor()
        let router: PresenterToRouterProtocol = ConversationRoute()
        
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
