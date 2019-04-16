//
//  UploadInvoiceInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 21/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation
import RxSwift
import ReusableFramework


class UploadInvoiceInteractor: PresentorToInterectorProtocol, APIMultipartRequest{
    
    
    var multiFormData: MultipartEntity
    var url: String
    var headers: [String : String]
    var presenter: InterectorToPresenterProtocol?
    var response: CreateSubGroupResponse!
    
    init() {
        url = GlobalConstants.base +  CameraApis.uploadInvoices
        headers = url.getHeader()
        multiFormData = MultipartEntity(parameters: [:], imageData: nil)
    }
    func fetchData<T>(body: T) where T : Decodable, T : Encodable {
    
        if let data  = body as? UploadInvoiceEntity{
            
            if let invoices = data.invoiceDetails{
                if let invoiceDetails = getParameters(data: invoices){
                    let (userId, companyId) = CredentialsCheck.usersIdAndHisCompanyId()
                    let serverDetails = [
                        "invoiceDetails" :  invoiceDetails,
                        "userId" : userId,
                        "companyId" : companyId,
                        "projectId" : data.projectId ?? "" ,
                        "billTitle" : data.billTitle ?? ""
                    ]
                    if let imageData = data.imageData{
                        var multiImagesArray = [MultipartImageInfoEntity]()
                        
                        for image in imageData{
                        multiImagesArray.append(MultipartImageInfoEntity(imageData: image, withName: "file"))
                        }
                        multiFormData = MultipartEntity(parameters: serverDetails, imageData: multiImagesArray)
                        
                    }else{
                        multiFormData = MultipartEntity(parameters: serverDetails, imageData: nil)
                    }
                    
                    callServer()
                    
                }
            }
        }
    }
    
    func fetchData() { }
    
    func getParameters(data: [MultiAiModel]) -> String?{
        
        var invoiceData = [[String: String]]()
        for invoice in data{
            var invoices = [String: String]()
            
            if let totalAmount = invoice.total_amount{
                invoices.updateValue(String(totalAmount), forKey: "total_amount")
            }
            
            if let tax = invoice.tax{
                invoices.updateValue(tax, forKey: "tax_amount")
            }
            
            if let selectedCvr = invoice.selectedCvr{
                 invoices.updateValue(selectedCvr, forKey: "cvr")
            }
            
            if let selectedDate = invoice.selectedDate{
                invoices.updateValue(selectedDate, forKey: "date")
            }
            invoiceData.append(invoices)
        }
        let dat = try? JSONSerialization.data(withJSONObject: invoiceData, options: .prettyPrinted)
        if let invoiceString = dat{
            
            let str = String(data: invoiceString, encoding: String.Encoding.utf8)
            
           return str
        }
        
        return nil
    }

    
    func callServer(){
        
        let uploadInvoices: Observable<CreateSubGroupResponse> = Network.shared.multipartRequest(request: self)
        
        uploadInvoices.subscribe(onNext: { (response) in
            self.response = response
        }, onError: { (error) in
            self.presenter?.dataFetchedFailed(error: error.localizedDescription)
        }, onCompleted: {
            if self.response.error == true{
                self.presenter?.dataFetchedFailed(error: self.response.message!)
            }else{
                self.presenter?.dataFetched(news: self.response.message!)
            }
        }) {
            
        }
        
    }
    
}



