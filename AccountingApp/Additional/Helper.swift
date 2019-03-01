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
    
    
    class func convertDateToTimeStamp(date: Date) -> CLong{
        
        // convert Date to TimeInterval (typealias for Double)
        
        let timeInterval = date.timeIntervalSince1970
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        
        let convertedUtcDate = dateFormatter.date(from: convertDateToServerFormat(date: date))
        
        guard let utcDate = convertedUtcDate else{
            return CLong(timeInterval)
        }
        
        
        return CLong(utcDate.timeIntervalSince1970)
    }
    
    class func returnCalendarDates() -> (Date, Date){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = formatter.date(from: "2000/1/01 22:31")
        
        
        
        let startDate = Date()
        var components = DateComponents()
        components.setValue(1, for: .year)
        let calendar = Calendar(identifier: .gregorian)
        let endingDate = calendar.date(byAdding: components, to: startDate)
        
        guard let startingDate = someDateTime else {
            return (Date(), Date())
        }
        
        guard let endDate = endingDate else {
            return (Date(), Date())
        }
        
        
        return (startingDate, endDate)
        
        
        
    }
    
    class func addOneToDate(date: Date) -> Date{
        
        var components = DateComponents()
        components.day = 1
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(byAdding: components, to: date)!
        
    }
    
   class func convertDateToServerFormat(date: Date) -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        
        
        print(formatter.string(from: date))
        return   formatter.string(from: date)
        
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
    
    
    class func getFullName(firstName: String?, lastName: String?) -> String{
        
        var fullName = ""
        
        if let first = firstName{
            fullName = fullName + first + " "
        }
        
        if let last = lastName{
            fullName = fullName + last
        }
        
        
        
        return  fullName
    }
    
    
    class func createAssigneeList(list: [String?: String?]) -> String{
        var finalKey = ""
        
        for (key, _) in list{
            
            if let keyValue = key{
                finalKey.append(keyValue)
                finalKey.append(",")
            }
            
            
        }
       
  
        return String(finalKey.dropLast())
    }
    

    class func timeAgoSinceDate(_ date:Date,currentDate:Date, numericDates:Bool) -> String {
        let calendar = Calendar.current
        let now = currentDate
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
        
    }
}
