//
//  SeenByController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 04/03/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class SeenByController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gestureView: UIView!
    @IBOutlet var toolBarView: UIToolbar!
    @IBOutlet var searchBar: UISearchBar!
    
    var presenter: ViewToPresenterProtocol?
    var seenByMember: [SeenByDataModel]?{
        didSet{
            searchByMember = seenByMember
        }
    }
    var searchByMember: [SeenByDataModel]?
    var commentId: SeenByRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter?.updateView(body: commentId)
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

extension SeenByController{
    
    func addGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        gestureView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
}
extension SeenByController: UITableViewDataSource, UITableViewDelegate{
    
    func configureTableView(){
        tableView.register(UINib(nibName: "SeenByCell", bundle: nil), forCellReuseIdentifier: "SeenByCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchByMember?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeenByCell", for: indexPath) as! SeenByCell
        cell.seenBy = searchByMember?[indexPath.item]
        return cell
    }
    
}

extension SeenByController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchByMember = searchText.isEmpty ? seenByMember : seenByMember?.filter({ (hotel) -> Bool in
            return hotel.FirstName?.range(of: searchText, options: .caseInsensitive) != nil
        })
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension SeenByController: PresenterToViewProtocol{
    func showContent<T>(news: T) {
        if let data = news as? [SeenByDataModel]{
            seenByMember = data
            tableView.reloadData()
        }
    }
    func showError<T>(error: T) {
        if let unwrappedError = error as? String{
            self.showAlert(message: unwrappedError)
        }
    }
}
