//
//  ProjectsController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

class ProjectsController: UIViewController{
    
    var presenter: ViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hideTranslucency()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Invoice"
        //navigationController?.navigationBar.prefersLargeTitles = false
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
        //navigationController?.navigationBar.prefersLargeTitles = true
        tabBarController?.tabBar.isHidden = true
    }
    
}

extension ProjectsController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0,1: return 1
        default: return 5
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section{
        case 0: return 200
        case 1: return 46 + 16 + 12
        default:
            return UITableView.automaticDimension
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectsCell", for: indexPath) as! ProjectsCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectDateCell", for: indexPath) as! ProjectDateCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectTaskCell", for: indexPath)
            return cell
   
        }
        
    }
    
}

extension ProjectsController{
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 2{
            return true
        }
        
        return false
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            
            print("copy button tapped")
            
        }
        deleteButton.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        //deleteButton.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "deleteProject"))
        
        
        let editButton = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            
            print("Access button tapped")
            
        }
        //editButton.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "editTask"))
        editButton.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        
        return [deleteButton, editButton]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let allProjects = AllProjectsRoutes.createModule()
        navigationController?.pushViewController(allProjects, animated: true)
    }
}


extension ProjectsController: PresenterToViewProtocol {
    func showContent<T>(news: T) {
        
    }
    
    func showError() {
        
    }
    
    
    
}

