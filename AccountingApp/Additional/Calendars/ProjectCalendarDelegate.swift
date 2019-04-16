//
//  ProjectCalendarDelegate.swift
//  CameraApp
//
//  Created by Jeevan Tiwari on 28/09/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit
import JTAppleCalendar

extension ProjectCalendar: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource{
    
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {

        guard let cells =  cell as? CalendarViewCell else {
            return
        }
        selectedState(cellState: cellState, cell: cells)
      //  hideNextMonthDates(cellState: cellState, cell: cells)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarViewCell", for: indexPath) as! CalendarViewCell
        cell.dateLabel.text = cellState.text
        //selectedState(cellState: cellState, cell: cell)
        hideNextMonthDates(cellState: cellState, cell: cell)
        return cell
    }
    
    func hideNextMonthDates(cellState: CellState, cell: CalendarViewCell){
        if cellState.dateBelongsTo == .thisMonth{
            cell.dateLabel.textColor = .black
            cell.isUserInteractionEnabled = true
            selectedState(cellState: cellState, cell: cell)
        }else{
            cell.dateLabel.textColor = .white
            cell.selectedView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.isUserInteractionEnabled = false
            
        }
        
        

    }
    
    func selectedState(cellState: CellState, cell: CalendarViewCell){
        if cellState.isSelected {
            cell.selectedView.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
          //  cell.dateLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else{
            cell.selectedView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            //cell.dateLabel.textColor = .black
        }
//        else{
//
//            if cellState.dateBelongsTo == .thisMonth{
//                cell.selectedView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//                cell.dateLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            }else{
//                cell.dateLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//                cell.selectedView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            }
//
//        }
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        
        let (startDate, endDate) = Helper.returnCalendarDates()
        
        return ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: 6, calendar: Calendar.current, generateInDates:  .forAllMonths, generateOutDates: .tillEndOfGrid, firstDayOfWeek: .sunday, hasStrictBoundaries: false)
    }
    
    
    
    
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let calendarCell = cell as? CalendarViewCell else {
            return
        }
//        calendarCell?.selectedView.isHidden = false
//        calendarCell?.dateLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        calendarCell?.selectedView.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
         header.monthLabel.text = Helper.convertDateToServerFormat(date: cellState.date)
        selectedState(cellState: cellState, cell: calendarCell )
        if selectedDate == DefaultSelectedDate.STARTDATE{
            startDate = cellState.date
        }else if selectedDate == DefaultSelectedDate.ENDDATE{
            endDate = cellState.date
        }
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        let calendarCell = cell as? CalendarViewCell
        //calendarCell?.selectedView.isHidden = true
        calendarCell?.dateLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        calendarCell?.selectedView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {

        let getCalendar = Calendar(identifier: .gregorian)
        var dateComponent = DateComponents()
        dateComponent.setValue(15, for: .day)

        header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "CalendarViewHeader", for: indexPath) as? CalendarViewHeader


        header.monthLabel.text = "\(Helper.getMonth(date: getCalendar.date(byAdding: dateComponent, to: range.start)!)) '\(Helper.lastgetYear(date: getCalendar.date(byAdding: dateComponent, to: range.start)!))"
        return header

    }


    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize.init(defaultSize: taskCalendar.frame.width * 0.1)
    }
}


