//
//  InvoiceDatabase.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit
import CoreData

class InvoiceDatabase{
    
    class func saveInvoices(invoices: [InvoiceModel], context: AppDelegate) /*-> InvoiceEntity?*/{
        
       
        ProfileDatabase.deleteData(entityName: "Invoices", context: context)
        
        for invoice in invoices{
            
            if let invoiceEntity = NSEntityDescription.insertNewObject(forEntityName: "Invoices", into: context.persistentContainer.viewContext) as? Invoices{
                invoiceEntity.createdDate = Helper.convertStringToDate(date: invoice.createdDate)
               
                invoiceEntity.date = "\(Helper.getMonthShort(date: Helper.convertStringToDate(date: invoice.createdDate))) \(Helper.getDate(date: Helper.convertStringToDate(date: invoice.createdDate)))  \(Helper.getYear(date: Helper.convertStringToDate(date: invoice.createdDate)))"
                
                if let cost = invoice.totalAmount{
                    invoiceEntity.cost = "$\(cost)"
                }
                
                invoiceEntity.detail = invoice.billTitle
                
                var imageArray = getImageArray(images: invoice.fileDetails)
                
                if let details = invoice.invoiceDetails{
                    for detail in details{
                        
                        if let invoiceDetailsEntity = NSEntityDescription.insertNewObject(forEntityName: "InvoiceDetails", into: context.persistentContainer.viewContext) as? InvoiceDetails{
                            
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
//                            imageArray.removeFirst()
                            
                        }
                    }
                    
                }
            }
            
        }
        
        //DispatchQueue.main.async {
           // if let appdelegate = UIApplication.shared.delegate as? AppDelegate{
                 context.saveContext()
                
           // }
       // }
       
//return getInvoice(invoices: <#T##Invoices#>)
        
        
    }
    
    class func getInvoicesFromDatabase(appDelegate: AppDelegate) -> InvoiceEntity?{
        
        
        
//        guard let appDelate = UIApplication.shared.delegate as? AppDelegate else{
//            return nil
//        }
        
        let fetchRequest = NSFetchRequest<Invoices>(entityName: "Invoices")
        let sortedDescription = NSSortDescriptor(key: #keyPath(Invoices.date), ascending: false)
        fetchRequest.sortDescriptors = [sortedDescription]
        
        do{
            let invoices = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            
            
            var pendingInvoice = [InvoiceDetailEntity]()
            var scannedInvoice = [InvoiceDetailEntity]()
            
            
            for invoice in invoices{
            
                if let _ = invoice.invoiceId{
                    
                    pendingInvoice.append(InvoiceDetailEntity(date: invoice.date, detail: invoice.detail, cost: invoice.cost, invoiceDescription: getInvoice(invoices: invoice)))
                    
                }else{
                    scannedInvoice.append(InvoiceDetailEntity(date: invoice.date, detail: invoice.detail, cost: invoice.cost, invoiceDescription: getInvoice(invoices: invoice)))
                }
            }
            
            return InvoiceEntity(scanned: scannedInvoice, unscanned: pendingInvoice)
            
            
            
        }catch let err{
            
        }
        
        return nil
        
    }
    
    class func getInvoice(invoices: Invoices) -> [InvoiceDescription]{
        
        var invoiceDetailArray = [InvoiceDescription]()
        
        if let invoiceDetails = invoices.invoiceDetail{
            
            for invoiceDetail in invoiceDetails{
                
                if let invoice = invoiceDetail as? InvoiceDetails{
                    let invoiceEntity = InvoiceDescription(cvr: invoice.cvr, tax: invoice.tax, amount: invoice.amount, date: invoice.date, image: invoice.image)
                    invoiceDetailArray.append(invoiceEntity)
                }
                
            }
            
        }
        
        return invoiceDetailArray
   
    }
    
    class func getImageArray(images: [InvoiceDataImageModel]?) -> [String]{
        
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
