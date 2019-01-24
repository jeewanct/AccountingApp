//
//  AccountingProtocols.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

protocol PresenterToViewProtocol: class {
    func showContent<T>(news: T)
    func showError<T>(error: T)
}

protocol InterectorToPresenterProtocol: class {
    func dataFetched<T>(news: T)
    func dataFetchedFailed<T>(error: T)
}

protocol PresentorToInterectorProtocol: class {
    var presenter: InterectorToPresenterProtocol? {get set}
    func fetchData<T: Codable>(body: T)
    func fetchData()
}

protocol ViewToPresenterProtocol: class {
    var view: PresenterToViewProtocol? {get set};
    var interector: PresentorToInterectorProtocol? {get set};
    var router: PresenterToRouterProtocol? {get set}
    func updateView<T: Codable>(body: T)
    func updateView()
}

protocol PresenterToRouterProtocol: class {
    static func createModule() -> UIViewController
}


protocol CellClicked: class{
    func cellClicked<T>(data: T)
}

