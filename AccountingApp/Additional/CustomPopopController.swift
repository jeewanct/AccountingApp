//
//  CustomPopopController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 21/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

protocol ProjectSelectedDelegate: class{
    func didSelectedProject(withName name: String?, andProjectId projectId: String? ,startDate: Date?, endDate: Date?)
}


class CustomPopUpController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gestureView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var toolBarView: UIToolbar!
    
    var projectList: [CameraProjectUIEntity]?
    {
        didSet{
            searchProjectList = projectList
        }
    }
    var searchProjectList: [CameraProjectUIEntity]?
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
        return searchProjectList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.07
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        cell.rightImageView.isHidden = true
        cell.subGroupName.text = searchProjectList?[indexPath.item].name
        return cell
    }
    
}

extension CustomPopUpController{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectedProject(withName: projectList?[indexPath.item].name, andProjectId: searchProjectList?[indexPath.item].projectId, startDate: searchProjectList?[indexPath.item].startDate, endDate: searchProjectList?[indexPath.item].endDate)
        handleClose("")
    }
}


extension CustomPopUpController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchProjectList = searchText.isEmpty ? projectList : projectList?.filter({ (hotel) -> Bool in
            return hotel.name?.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        tableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
