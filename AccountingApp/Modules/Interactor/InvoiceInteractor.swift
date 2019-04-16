//
//  InvoiceInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit
import RxSwift
import CoreData
import ReusableFramework

class InvoiceInteractor: PresentorToInterectorProtocol, APIRequest{
  
    var method: RequestType
    var path: String
    var parameters: Data?
    var headers: [String : String]
    var errorMessage = ""
    var invoiceData: [InvoiceModel]?
    var context: AppDelegate
    
    init() {
        method = RequestType.GET
        let (userId, companyId) = UserHelper.companyID()
        path = InvoiceApis.getInvoiceList + GlobalConstants.userId + "\(userId)" + GlobalConstants.companyId + "\(companyId)"
        parameters = Data()
        headers = path.getHeader()
        
        context = AppDelegate()
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            context = appDelegate
        }

    }
    
    var presenter: InterectorToPresenterProtocol?
    
    func fetchData<T>(body: T) where T : Decodable, T : Encodable {
        
    }
    
    
    func fetchData() {
        
        let invoiceList: Observable<InvoiceResponseEntity> = Network.get(apiRequest: self)
        
        invoiceList.subscribe(onNext: { (response) in
            
            if response.error == true{
                if let message = response.message{
                    if response.code == ErrorCodeEnum.logout.rawValue{
                        self.errorMessage = ErrorCodeEnum.logout.rawValue
                    }else{
                        self.errorMessage = message
                    }
                }
            }else{
                self.invoiceData = response.data
            }
            
        }, onError: { (error) in
            self.presenter?.dataFetchedFailed(error: error.localizedDescription)
        }, onCompleted: {
            
            if self.errorMessage == ErrorCodeEnum.logout.rawValue{
                self.presenter?.dataFetchedFailed(error: self.errorMessage)
            }else if self.errorMessage == ""{
                self.removeInvoices()
            }else {
                self.presenter?.dataFetchedFailed(error: self.errorMessage)
            }
            self.errorMessage = ""
            
        }) {
            
        }
       
        
    }
    
    
    func removeInvoices(){

        if let invoices = invoiceData{
            
            if let invoices = InvoiceDatabase.saveInvoices(invoices: invoices, context: context){
                self.presenter?.dataFetched(news: invoices)
                
            }else{
                self.presenter?.dataFetchedFailed(error: AlertMessage.fetchError.rawValue)
            }
            

        }else{
            presenter?.dataFetchedFailed(error: AlertMessage.fetchError.rawValue)
        }
        
        
    }
    
    
}
