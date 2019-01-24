//
//  ReportsPresenter.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import Foundation

class ReportsPresenter: ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?;
    var interector: PresentorToInterectorProtocol?;
    var router: PresenterToRouterProtocol?
    
    func updateView<T>(body: T) {
        
    }
    
    func updateView() {
        
    }
}

extension ReportsPresenter: InterectorToPresenterProtocol {
    func dataFetched<T>(news: T) {
        
    }
    
    func dataFetchedFailed<T>(error: T) {
        
    }
}
