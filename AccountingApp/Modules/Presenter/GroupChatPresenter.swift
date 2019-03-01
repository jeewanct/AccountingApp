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
    
    func updateView<T: Codable>(body: T) {
        
        interector?.fetchData(body: body)
    }
    
    func updateView() {
        
    }
    
}

extension GroupChatPresenter: InterectorToPresenterProtocol {
    
    func dataFetched<T>(news: T) {
        DispatchQueue.main.async {
            self.view?.showContent(news: news)
        }
    }
    
    func dataFetchedFailed<T>(error: T) {
        
        DispatchQueue.main.async {
            self.view?.showError(error: error)
        }
        
    }
    
}
