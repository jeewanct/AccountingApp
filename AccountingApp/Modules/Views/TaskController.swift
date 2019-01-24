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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func handleProject(_ sender: Any) {
    }
    
    @IBAction func handleTaskDate(_ sender: Any) {
    }
    
    @IBAction func handleSelectHrs(_ sender: Any) {
    }
    @IBAction func handleSelectMins(_ sender: Any) {
    }
    
    
    @IBAction func handleSave(_ sender: Any) {
    }
    
    var presenter: ViewToPresenterProtocol?
    
}


extension TaskController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        
    }
    
    func showError<T>(error: T) {
        
    }
    
}

