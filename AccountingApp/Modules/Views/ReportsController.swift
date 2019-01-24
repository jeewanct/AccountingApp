//
//  ReportsController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

class ReportsController: UITableViewController{
    
    var presenter: ViewToPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hideTranslucency()
    }
}


extension ReportsController: PresenterToViewProtocol {
    func showContent<T>(news: T) {
        
    }
    
    func showError<T>(error: T) {
        
    }

}
