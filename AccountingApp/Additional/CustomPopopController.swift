//
//  CustomPopopController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 21/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

protocol ProjectSelectedDelegate: class{
    func didSelectedProject(withName name: String?, andProjectId is: String?)
}


class CustomPopUpController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gestureView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var toolBarView: UIToolbar!
    
    var projectList: [CameraProjectUIEntity]?
    weak var delegate: ProjectSelectedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGesture()
        configureTableView()
    }
    
    @IBAction func handleSubmit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func handleDismiss(_ sender: Any) {
        view.endEditing(true)
    }
    
    
}

extension CustomPopUpController{
    
    func addGesture(){
        
        searchBar.inputAccessoryView = toolBarView
        searchBar.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        gestureView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
}


extension CustomPopUpController: UITableViewDataSource, UITableViewDelegate{
    
    func configureTableView(){
        tableView.register(UINib(nibName: "GroupCell", bundle: nil), forCellReuseIdentifier: "GroupCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.06
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        cell.rightImageView.isHidden = true
        cell.subGroupName.text = projectList?[indexPath.item].name
        return cell
    }
    
}

extension CustomPopUpController{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectedProject(withName: projectList?[indexPath.item].name, andProjectId: projectList?[indexPath.item].projectId)
        handleClose("")
    }
}


extension CustomPopUpController: UISearchBarDelegate{
    
}
