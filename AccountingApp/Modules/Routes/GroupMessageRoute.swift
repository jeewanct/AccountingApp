//
//  GroupMessageRoute.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 14/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit


class GroupMessageRoute: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        let view = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "GroupMessagesController") as? GroupMessagesController
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = GroupMessagePresenter()
        let interactor: PresentorToInterectorProtocol = GroupMessageInteractor()
        let router: PresenterToRouterProtocol = GroupMessageRoute()
        
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


