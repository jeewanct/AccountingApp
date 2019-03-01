//
//  TaskCalendar.swift
//  CameraApp
//
//  Created by Jeevan Tiwari on 15/09/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit
import JTAppleCalendar

class TaskCalendar: UIViewController{
    
    @IBOutlet weak var taskCalendar: JTAppleCalendarView!
    
    var projectStartingDate: Date?
    var startDate: Date?
    var delegate: CalendarDatesDelegate?
    var projectEndingDate: Date?
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendarView()
    }
    
    func setCalendarView(){
        
        // taskCalendar.cellSize = 200
        taskCalendar.calendarDataSource = self
        taskCalendar.calendarDelegate = self
        taskCalendar.minimumInteritemSpacing = 0
        taskCalendar.minimumLineSpacing = 0
        taskCalendar.scrollDirection = .horizontal
        taskCalendar.isPagingEnabled = true
        taskCalendar.backgroundColor = .white
        taskCalendar.isUserInteractionEnabled = true
        taskCalendar.register(CalendarViewCell.self, forCellWithReuseIdentifier: "CalendarViewCell")
        taskCalendar.register(CalendarViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CalendarViewHeader")
        // cv.scrollingMode = .stopAtEachSection
        //cv.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 5)
        taskCalendar.showsHorizontalScrollIndicator = false
        
        
        if let getStartDate = projectStartingDate{
            
            taskCalendar.selectDates([getStartDate])
        }
        
    }
    
    @IBAction func handleClose(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func handleSubmit(_ sender: Any) {
        if let _  = projectStartingDate {
            
            if let startingDate = startDate{
                
                let startDating = Helper.convertDateToServerFormat(date: startingDate)
                
                let dateFormatter = DateFormatter()
                //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.timeZone =  TimeZone(abbreviation: "GMT")  //[NSTimeZone timeZoneWithName:@"GMT"];
                dateFormatter.dateFormat = "dd/MM/yyyy"
                
                
                let toDate = dateFormatter.date(from: startDating)
                
                
                
                
                delegate?.setCalendarDates(startDate: toDate, endDate: nil)
                
                handleClose((Any).self)
            }
            
            
            
        }
    }
    
    
}
