//
//  CreateSubGroupInteracto.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 18/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//



import Foundation
import ReusableFramework


class CreateSubGroupInteractor: PresentorToInterectorProtocol{
    
    var presenter: InterectorToPresenterProtocol?
    
    func fetchData<T>(body: T) where T : Decodable, T : Encodable {
        
        let url = GlobalConstants.base + LoginApis.forgotPasswordUrl
        
        do{
            let data = try JSONEncoder().encode(body.self)
            getDataFromServer(url: url, data: data)
        }catch let error{
            
        }
    }
    
    func fetchData() {
        
    }
    
    func getDataFromServer(url: String, data: Data){
        //        Networking.shared.postRequest(url: url, header: url.getHeader(), data: data, completion: { (forgotPass: ForgotResponseEntity) in
        //
        //            self.presenter?.dataFetched(news: forgotPass)
        //
        //        }) { (error) in
        //            self.presenter?.dataFetchedFailed()
        //        }
        
    }
    
}
