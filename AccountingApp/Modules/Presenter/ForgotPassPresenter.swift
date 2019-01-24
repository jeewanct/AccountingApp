//
//  ForgotPassPresenter.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//
import Foundation

class ForgotPassPresenter: ViewToPresenterProtocol {
    
    
    var view: PresenterToViewProtocol?;
    var interector: PresentorToInterectorProtocol?;
    var router: PresenterToRouterProtocol?
    
    func updateView<T>(body: T) where T : Decodable, T : Encodable {
        interector?.fetchData(body: body)
    }
    
    func updateView() {
        
    }
    
}

extension ForgotPassPresenter: InterectorToPresenterProtocol {
    
    func dataFetched<T>(news: T) {
        view?.showContent(news: news)
    }
    
    func dataFetchedFailed<T>(error: T) {
        view?.showError(error: error)
    }
    
}
