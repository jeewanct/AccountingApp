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
    
    func updateView<T>(body: T) where T : Decodable, T : Encodable {
        interector?.fetchData(body: body)
    }
    
    func updateView() {
        
    }
    
}



extension ProjectsPresenter: InterectorToPresenterProtocol {
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



