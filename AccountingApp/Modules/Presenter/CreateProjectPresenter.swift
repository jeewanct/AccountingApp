//
//  CreateProjectPresenter.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 19/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//




import Foundation

class CreateProjectPresenter: ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?;
    var interector: PresentorToInterectorProtocol?;
    var router: PresenterToRouterProtocol?
    
    func updateView<T>(body: T) where T : Decodable, T : Encodable {
        interector?.fetchData(body: body)
    }
    
    func updateView() {
        interector?.fetchData()
    }
    
}

extension CreateProjectPresenter: InterectorToPresenterProtocol {
    
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

