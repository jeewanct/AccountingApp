//
//  GroupChatPresenter.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 15/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation

class GroupChatPresenter: ViewToPresenterProtocol {
    
    
    var view: PresenterToViewProtocol?;
    var interector: PresentorToInterectorProtocol?;
    var router: PresenterToRouterProtocol?
    
    func updateView<T>(body: T) where T : Decodable, T : Encodable {
        interector?.fetchData(body: body)
    }
    
    func updateView() {
        
    }
    
}

extension GroupChatPresenter: InterectorToPresenterProtocol {
    
    func dataFetched<T>(news: T) {
        
    }
    
    func dataFetchedFailed<T>(error: T) {
        view?.showError(error: error)
    }
    
}
