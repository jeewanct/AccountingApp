//
//  CreateSubGrouController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 18/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class CreateSubGrouController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    
    var presenter: ViewToPresenterProtocol?
    
}

extension CreateSubGrouController{
    
    func configureTableView(){
        navigationItem.title = GroupMessageEnum.createSubGroup.rawValue
        tableView.register(UINib(nibName: "CreateSubgroupCell", bundle: nil), forCellReuseIdentifier: "CreateSubgroupCell")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height - self.navigationBarHeight 
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreateSubgroupCell", for: indexPath) as! CreateSubgroupCell
        return cell
    }
    
}


extension CreateSubGrouController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        
    }
    
    func showError<T>(error: T) {
        
    }
    
}

