//
//  ProjectInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit


class ProjectInteractor: PresentorToInterectorProtocol{
    
    
    
    var presenter: InterectorToPresenterProtocol?
    
    func fetchData<T>(body: T) where T : Decodable, T : Encodable {
        
    }
    
    func fetchData() {
        
    }
}