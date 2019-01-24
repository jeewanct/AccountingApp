//
//  Helper.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

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
    
    class func getDayName(date: Date) -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
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
    
    class func projectDayDate(date: CLong?) -> (String, String){
        
        let date1 = convertStringToDate(date: date)
        let dateText = getDayName(date: date1)
        let dayName  = "\(getDate(date: date1)) \(getMonth(date: date1)) "
        
        return (dayName, dateText)
    }
    
    class func getProjectStartingDate(date: Date) -> String{
        
        return "\(getDate(date: date)) \(getMonthShort(date: date)) \(getYear(date: date))"
    }
    
    // class func
    
    
    
    func saveImageToPath(image: UIImage, imageName: String){
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let fileURL = documentsDirectory.appendingPathComponent(imageName)
      
        if let data = image.jpegData(compressionQuality: 1.0),
            !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try data.write(to: fileURL)
                print("file saved")
            } catch { }
        }else{ }
        
        
    }
    

}
