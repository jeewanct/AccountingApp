//
//  InvoiceInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class InvoiceInteractor: PresentorToInterectorProtocol{
    
    var presenter: InterectorToPresenterProtocol?
    
    
    func fetchData<T>(body: T) where T : Decodable, T : Encodable {
        
    }
    
    
    func fetchData() {
        
        let (userId, companyId) = UserHelper.companyID()
        
        let url = GlobalConstants.base + InvoiceApis.getInvoiceList + "?UserId=\(userId)&companyId=\(companyId)"
        
//        Networking.shared.getRequest(url: url, header: url.getHeader(), completion: { (invoiceData: InvoiceResponseEntity) in
//            
//            if let invoiceList = invoiceData.data{
//                self.removeInvoices()
//                self.saveInvoices(invoices: invoiceList)
//            }
//            
//        }) { (error) in
//            self.presenter?.dataFetchedFailed()
//        }
        
    }
    
    
    func removeInvoices(){
        
        guard let appDelate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        
        let fetchRequest = NSFetchRequest<Invoices>(entityName: "Invoices")
        do{
            let invoices = try appDelate.persistentContainer.viewContext.fetch(fetchRequest)
            
            for invoice in invoices{
                appDelate.persistentContainer.viewContext.delete(invoice)
            }
            
        }catch let err{
            
        }
        
        
    }
    
    
    func saveInvoices(invoices: [InvoiceModel]){
        
        guard let appDelate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        for invoice in invoices{
            
            if let invoiceEntity = NSEntityDescription.insertNewObject(forEntityName: "Invoices", into: appDelate.persistentContainer.viewContext) as? Invoices{
                
                invoiceEntity.date = "\(Helper.getMonthShort(date: Helper.convertStringToDate(date: invoice.createdDate))) \(Helper.getDate(date: Helper.convertStringToDate(date: invoice.createdDate)))  \(Helper.getYear(date: Helper.convertStringToDate(date: invoice.createdDate)))"
                
                if let cost = invoice.totalAmount{
                    invoiceEntity.cost = "$\(cost)"
                }
                
                invoiceEntity.detail = invoice.billTitle
                
                var imageArray = getImageArray(images: invoice.fileDetails)
                
                if let details = invoice.invoiceDetails{
                    for detail in details{
                        
                        if let invoiceDetailsEntity = NSEntityDescription.insertNewObject(forEntityName: "Invoices", into: appDelate.persistentContainer.viewContext) as? InvoiceDetails{
                            
                            if let amount = detail.total_amount {
                                invoiceDetailsEntity.amount = String(amount)
                            }
                            
                            if let tax = detail.tax_amount{
                                invoiceDetailsEntity.amount = String(tax)
                            }
                            
                            if let image = imageArray.first{
                                invoiceDetailsEntity.image = image
                            }
                            
                            invoiceDetailsEntity.date = detail.date
                            
        
                            invoiceEntity.addToInvoiceDetail(invoiceDetailsEntity)
                            imageArray.removeFirst()
                            
                        }
                    }
                    
                }
            }
            
        }
        
        appDelate.saveContext()
        
        getInvoicesFromDatabase()
        
    }
    
    func getInvoicesFromDatabase(){
        
        guard let appDelate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        var invoiceData = InvoiceData()
        
        var pendingInvoice = [Invoices]()
        var scannedInvoice = [Invoices]()
        
        let fetchRequest = NSFetchRequest<Invoices>(entityName: "Invoices")
        do{
            let invoices = try appDelate.persistentContainer.viewContext.fetch(fetchRequest)
            
            for invoice in invoices{
                if let id = invoice.invoiceId{
                    pendingInvoice.append(invoice)
                }else{
                    scannedInvoice.append(invoice)
                }
            }
            invoiceData.pendingInvoice = pendingInvoice
            invoiceData.scannedInvoice = scannedInvoice
            presenter?.dataFetched(news: invoiceData)
            
        }catch let err{
            
        }
        
    }
    
    func getImageArray(images: [InvoiceDataImageModel]?) -> [String]{

        guard let unwrappedImages = images else {
            return []
        }
        
        var imageArray = [String]()
        for image in unwrappedImages{
            
            if let imagePath = image.imagepath{
                imageArray.append(imagePath)
            }
        }
        return imageArray
        
    }
    
    
}
