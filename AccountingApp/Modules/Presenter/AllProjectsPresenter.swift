//
//  AllProjectsPresenter.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 14/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation

class AllProjectsPresenter: ViewToPresenterProtocol {
    
    
    var view: PresenterToViewProtocol?;
    var interector: PresentorToInterectorProtocol?;
    var router: PresenterToRouterProtocol?
    
    func updateView<T>(body: T) where T : Decodable, T : Encodable {
        interector?.fetchData(body: body)
    }
    
    func updateView() {
        
    }
    
}

extension AllProjectsPresenter: InterectorToPresenterProtocol {
    
    func dataFetched<T>(news: T) {
        
    }
    
    func dataFetchedFailed() {
        view?.showError()
    }
    
}
