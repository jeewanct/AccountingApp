//
//  TaskCalendarDelegate.swift
//  CameraApp
//
//  Created by Jeevan Tiwari on 15/09/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit
import JTAppleCalendar


extension TaskCalendar: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource{
    
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarViewCell", for: indexPath) as! CalendarViewCell
        cell.dateLabel.text = cellState.text
        
        selectedState(cellState: cellState, cell: cell)
        projectTaskAvailable(cellState: cellState, cell: cell)
        hideNextMonthDates(cellState: cellState, cell: cell)
        return cell
    }
    
    func projectTaskAvailable(cellState: CellState, cell: CalendarViewCell){
        
        if let firstDate = projectStartingDate, let lastDate = projectEndingDate{
            
            
            // Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: cellState.date)
            
            if Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: cellState.date)! >= firstDate && Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: cellState.date)! <= lastDate{
                cell.isUserInteractionEnabled = true
            }else{
                cell.isUserInteractionEnabled = false
            }
            
        }
        
    }
    
    func hideNextMonthDates(cellState: CellState, cell: CalendarViewCell){
        
        if cellState.dateBelongsTo == .thisMonth{
            if let firstDate = projectStartingDate, let lastDate = projectEndingDate{
                if Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: cellState.date)! >= firstDate && Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: cellState.date)! <= lastDate{
                    //cell.isUserInteractionEnabled = true
                    cell.dateLabel.textColor = .black
                }else{
                    // cell.isUserInteractionEnabled = false
                    cell.dateLabel.textColor = .gray
                    //cell.isUserInteractionEnabled = true
                }
            }
            
            
            
        }else{
            cell.dateLabel.textColor = .white
            cell.isUserInteractionEnabled = false
        }
        
    }
    
    func selectedState(cellState: CellState, cell: CalendarViewCell){
        
        if cellState.isSelected {
            cell.selectedView.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
            cell.dateLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else{
            
            if cellState.dateBelongsTo == .thisMonth{
                cell.selectedView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.dateLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
            
        }
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        var startDate = Date()
        var components = DateComponents()
        components.setValue(1, for: .year)
        let calendar = Calendar(identifier: .gregorian)
        var endDate = calendar.date(byAdding: components, to: startDate)
        
        if let getStartDate = projectStartingDate, let getEndDate = projectEndingDate{
            
            startDate = getStartDate
            endDate = getEndDate
            
        }
        
        //        if let getStartDate = calendarStartDate{
        //
        //            startDate = getStartDate
        //
        //        }
        
        
        return ConfigurationParameters(startDate: startDate, endDate: endDate!, numberOfRows: 6, calendar: Calendar.current, generateInDates:  .forAllMonths, generateOutDates: .tillEndOfGrid, firstDayOfWeek: .sunday, hasStrictBoundaries: false)
    }
    
    
    
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        let calendarCell = cell as? CalendarViewCell
        calendarCell?.selectedView.isHidden = false
        calendarCell?.dateLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        calendarCell?.selectedView.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        startDate = cellState.date
        dateLabel.text = Helper.convertDateToServerFormat(date: cellState.date)
        //        if defaultValue == DefaultSelectedDate.STARTDATE{
        //            startDate = cellState.date
        //        }else if defaultValue == DefaultSelectedDate.ENDDATE{
        //            endDate = cellState.date
        //        }
        
    }
    
    
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        let calendarCell = cell as? CalendarViewCell
        calendarCell?.selectedView.isHidden = true
        calendarCell?.dateLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        calendarCell?.selectedView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    
    
    
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        
        
        let getCalendar = Calendar(identifier: .gregorian)
        var dateComponent = DateComponents()
        dateComponent.setValue(15, for: .day)
        
        
        
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "CalendarViewHeader", for: indexPath) as! CalendarViewHeader
        
        
        if let getDate = startDate{
            
        }
        
        header.monthLabel.text = "\(Helper.getMonth(date: getCalendar.date(byAdding: dateComponent, to: range.start)!)) '\(Helper.lastgetYear(date: getCalendar.date(byAdding: dateComponent, to: range.start)!))"
        return header
        
    }
    
    
    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize.init(defaultSize: UIScreen.main.bounds.height * 0.06)
    }
}




extension TaskCalendar{
    
    @objc func handleClose(){
        
        //        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
        //            self.cardView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        //        }, completion: {(value) in
        //            self.removeFromSuperview()
        //        })
        
    }
    
    
    //    @objc func handleOk(){
    //
    //
    //        if let _  = projectStartingDate {
    //
    //            if let startingDate = startDate{
    //
    //                let startDating = LogicHelper.shared.convertDateToServerFormat(date: startingDate)
    //
    //                let dateFormatter = DateFormatter()
    //                //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    //                dateFormatter.timeZone =  TimeZone(abbreviation: "GMT")  //[NSTimeZone timeZoneWithName:@"GMT"];
    //                dateFormatter.dateFormat = "dd/MM/yyyy"
    //
    //
    //                let toDate = dateFormatter.date(from: startDating)
    //
    //
    //
    //
    //                delegate?.setCalendarDates(startDate: toDate, endDate: nil)
    //
    //                handleClose()
    //            }
    //
    //
    //
    //        }
    //    }
}
