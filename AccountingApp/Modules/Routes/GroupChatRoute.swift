//
//  GroupChatRoute.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 15/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit


class GroupChatRoute: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        let view = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "GroupChatController") as? GroupChatController
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = GroupChatPresenter()
        let interactor: PresentorToInterectorProtocol = GroupChatInteractor()
        let router: PresenterToRouterProtocol = GroupChatRoute()
        
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

