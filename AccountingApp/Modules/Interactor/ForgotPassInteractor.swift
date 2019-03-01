//
//  ForgotPassInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import Foundation
import RxSwift
import ReusableFramework


class ForgotPassInteractor: PresentorToInterectorProtocol, APIRequest{
    
    var method: RequestType
    var path: String
    var parameters: Data?
    var headers: [String : String]
    var message = ""
    
    init() {
        method = RequestType.POST
        parameters = Data()
        headers = "".getHeader()
        path = LoginApis.forgotPasswordUrl
    }
    
    var presenter: InterectorToPresenterProtocol?
    
}

extension ForgotPassInteractor{
    
    func fetchData<T>(body: T) where T : Decodable, T : Encodable {
        
        let (data, error) =  EncodeData.getData(parameters: body)
        
        if let requestData = data{
            
            parameters = requestData
            
            
            let forgotResponse: Observable<ForgotResponseEntity> = Network.shared.post(apiRequest: self)
            
            forgotResponse.subscribe(onNext: { (response) in
               
                if let responseMessage = response.message{
                    self.message = responseMessage
                }
                
            }, onError: { (onError) in
                self.presenter?.dataFetchedFailed(error: onError.localizedDescription)
            }, onCompleted: {
                self.presenter?.dataFetched(news: self.message)
            }) {
                
            }
            
        }else{
            presenter?.dataFetchedFailed(error: NetworkError.parsingError)
        }
    }
    
    func fetchData() {}
    
    
}
