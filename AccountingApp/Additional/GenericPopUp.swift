//
//  CustomPopopController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 21/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit


class GenericPopUp: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gestureView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var toolBarView: UIToolbar!
    
    var list: [String]?{
        didSet{
            searchList = list
        }
    }
    
    var searchList:[String]?
    var parentInstance: UIViewController?
    
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

extension GenericPopUp{
    
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


extension GenericPopUp: UITableViewDataSource, UITableViewDelegate{
    
    func configureTableView(){
        tableView.register(UINib(nibName: "GroupCell", bundle: nil), forCellReuseIdentifier: "GroupCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.06
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        cell.rightImageView.isHidden = true
        cell.subGroupName.text = searchList?[indexPath.item]
        return cell
    }
    
}

extension GenericPopUp{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let controller = parentInstance as? TaskController{
            if controller.details.type == TaskPopEnum.hours{
                controller.hourBtn.setTitle(searchList?[indexPath.item], for: .normal)
            }else{
                controller.minBtn.setTitle(searchList?[indexPath.item], for: .normal)
            }
        }
        handleClose("")
    }
}


extension GenericPopUp: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchList = searchText.isEmpty ? list : list?.filter({ (hotel) -> Bool in
            return hotel.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        tableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
