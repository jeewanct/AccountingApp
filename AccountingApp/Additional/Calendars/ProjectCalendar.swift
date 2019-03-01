//
//  ProjectCalendar.swift
//  CameraApp
//
//  Created by Jeevan Tiwari on 28/09/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit
import JTAppleCalendar

enum DefaultSelectedDate{
    case STARTDATE
    case ENDDATE
}

protocol CalendarDatesDelegate {
    func setCalendarDates(startDate: Date?, endDate: Date?)
}


class ProjectCalendar: UIViewController{
    
    @IBOutlet weak var taskCalendar: JTAppleCalendarView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var movingView: UIView!
    @IBOutlet weak var leftAnchor: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendarView()
        selectedDate = DefaultSelectedDate.STARTDATE
        startDate = Date()
        endDate = Helper.addOneToDate(date: startDate)
    }
    
    
    
    func setCalendarView(){
        
        // taskCalendar.cellSize = 200
        //taskCalendar.cellSize = 100
        
        taskCalendar.calendarDataSource = self
        taskCalendar.calendarDelegate = self
        
        
        
        taskCalendar.scrollDirection = .horizontal
        //taskCalendar.isPagingEnabled = true
        taskCalendar.backgroundColor = .white
        //taskCalendar.isUserInteractionEnabled = true
        taskCalendar.register(CalendarViewCell.self, forCellWithReuseIdentifier: "CalendarViewCell")
        taskCalendar.register(CalendarViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CalendarViewHeader")
        
        taskCalendar.layoutIfNeeded()
        taskCalendar.cellSize = taskCalendar.frame.width / 7
        taskCalendar.showsHorizontalScrollIndicator = false
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        taskCalendar.selectDates([startDate])
        taskCalendar.scrollToHeaderForDate(Date())
        print(taskCalendar.selectedDates)
        //taskCalendar.scrollingMode = .stopAtEachSection
    }
    
    
    @IBAction func handleStart(_ sender: Any) {
        
        animateView(constant: false)
        selectedDate = DefaultSelectedDate.STARTDATE
        taskCalendar.deselectAllDates()
        taskCalendar.scrollToHeaderForDate(startDate)
        taskCalendar.selectDates([startDate])
        
        
    }
    
    
    @IBAction func handleEnd(_ sender: Any) {
        
        animateView(constant: true)
        selectedDate = DefaultSelectedDate.ENDDATE
        taskCalendar.deselectAllDates()
        taskCalendar.scrollToHeaderForDate(endDate)
        taskCalendar.selectDates([endDate])
        
        
    }
    
    func animateView(constant: Bool){
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            
            if constant == true{
                self.movingView.transform = CGAffineTransform(translationX: (UIScreen.main.bounds.width / 2 ) - 16, y: 0)
            }else{
                self.movingView.transform = .identity
            }
            
        }, completion: nil)
        
    }
    
    
    @IBAction func handleClose(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func handleSubmit(_ sender: Any) {
        
        if endDate < startDate{
            self.showAlert(message: AlertMessage.startDateIsGreaterThanendDate.rawValue)
            
            
        }else{
            let startDating = Helper.convertDateToServerFormat(date: startDate)
            
            let endDating = Helper.convertDateToServerFormat(date: endDate)
            
            let dateFormatter = DateFormatter()
            //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone =  TimeZone(abbreviation: "GMT")  //[NSTimeZone timeZoneWithName:@"GMT"];
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            
            let toDate = dateFormatter.date(from: startDating)
            
            let fromDate = dateFormatter.date(from: endDating)
            
            
            delegate?.setCalendarDates(startDate: toDate, endDate: fromDate)
            
            handleClose((Any).self)
        }
        
        
    }
    
    var header: CalendarViewHeader!
    var selectedDate: DefaultSelectedDate?
    var startDate = Date()
    var endDate = Date()
    var delegate: CalendarDatesDelegate?
    
    
    
}


extension ProjectCalendar{
    
    
    
    
}
