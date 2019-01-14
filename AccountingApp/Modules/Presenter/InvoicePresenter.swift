//
//  InvoicePresenter.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import Foundation

class InvoicePresenter: ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?;
    var interector: PresentorToInterectorProtocol?;
    var router: PresenterToRouterProtocol?
    
    func updateView<T>(body: T) {
        
    }
    
    func updateView() {
        interector?.fetchData()
    }
}

extension InvoicePresenter: InterectorToPresenterProtocol {
   
    func dataFetched<T>(news: T) {
        view?.showContent(news: news)
    }
    
    func dataFetchedFailed() {
        
    }
    
}
