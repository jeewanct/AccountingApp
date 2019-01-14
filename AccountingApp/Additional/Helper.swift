//
//  Helper.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import Foundation


class Helper{
    
    class func convertStringToDate(date: CLong?) -> Date {
        
        // let dateFormatter = DateFormatter()
        
        if let getDate = date{
            let date = Date(timeIntervalSince1970: TimeInterval(getDate / 1000))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            
            let convertedUtcDate = dateFormatter.string(from: date)
            
            guard let utcDate = dateFormatter.date(from: convertedUtcDate) else{
                return date
            }
            
            return utcDate
            
            
        }
        
        return Date()
        
        
        //Date(timeIntervalSince1970: TimeInterval(date / 1000))
        //dateFormatter.dateFormat = "MM-dd/yyyy HH:mm:ss"
        //return dateFormatter.date(from: date)!
    }
    
    class func getYear(date: Date) -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: date)
        
    }
    
    class func lastgetYear(date: Date) -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY"
        return dateFormatter.string(from: date)
        
    }
    
    
    class func getMonth(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
        
    }
    
    class func getMonthShort(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLL"
        return dateFormatter.string(from: date)
        
        
    }
    
    class func getDate(date: Date) -> String{
        
        let calendar = Calendar.current
        return String(calendar.component(.day, from: date))
        
    }
    
}
