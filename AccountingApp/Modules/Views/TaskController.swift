//
//  TaskController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 19/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class TaskController: UIViewController{
    
    @IBOutlet weak var selectProjectBtn: UIButton!
    @IBOutlet weak var taskNameLabel: UITextField!
    @IBOutlet weak var taskDateBtn: UIButton!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet var keyboardToolBar: UIToolbar!
    override func viewDidLoad() {
        super.viewDidLoad()
        addDelegates()
        navigationItem.title = ProjectEnum.Tasktitle.rawValue
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func handleDismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func handleProject(_ sender: Any) {
    }
    
    @IBAction func handleTaskDate(_ sender: Any) {
        openCalendar()
    }
    
    @IBAction func handleSelectHrs(_ sender: Any) {
    }
    @IBAction func handleSelectMins(_ sender: Any) {
    }
    
    
    @IBAction func handleSave(_ sender: Any) {
    }
    
    var presenter: ViewToPresenterProtocol?
    
}



// Setup Keyboard
extension TaskController: UITextFieldDelegate{
    
    func addDelegates(){
        taskNameLabel.delegate = self
        descriptionText.delegate = self
        taskNameLabel.inputAccessoryView = keyboardToolBar
        descriptionText.inputAccessoryView = keyboardToolBar
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case taskNameLabel:
            descriptionText.becomeFirstResponder()
        default:
            self.view.endEditing(true)
        }
        
        return false
    }
    
}


extension TaskController: CalendarDatesDelegate{
    func setCalendarDates(startDate: Date?, endDate: Date?) {
        
    }
    
    
    func openCalendar(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TaskCalendar") as! TaskCalendar
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .overCurrentContext
        // vc.projectStartingDate = convertedFirstDate
        // vc.projectEndingDate = convertedSecondDate
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension TaskController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        
    }
    
    func showError<T>(error: T) {
        
    }
    
}

