//
//  ProjectsPresenter.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import Foundation

class ProjectsPresenter: ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    var interector: PresentorToInterectorProtocol?
    var router: PresenterToRouterProtocol?
    
    func updateView<T>(body: T) {
        
    }
    
    func updateView() {
        
    }
    
}



extension ProjectsPresenter: InterectorToPresenterProtocol {
    func dataFetched<T>(news: T) {
        
    }
    
    func dataFetchedFailed() {
        
    }
    
}



