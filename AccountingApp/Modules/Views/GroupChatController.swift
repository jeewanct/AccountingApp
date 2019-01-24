//
//  GroupChatController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 15/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class GroupChatController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationItem.title = "Group Chat"

    }
    
    override func viewWillDisappear(_ animated: Bool) {
       
        super.viewWillDisappear(animated)
    
    }
    
    var sendMessageView: ReplyChatView!
    var presenter: ViewToPresenterProtocol?

}

extension GroupChatController{
    
    func setup(){
        sendMessageView = UIView.fromNib()
        sendMessageView.translatesAutoresizingMaskIntoConstraints = false
        sendMessageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        sendMessageView.rightAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        sendMessageView.heightAnchor.constraint(equalToConstant: 49).isActive = true
        
        if #available(iOS 11.0, *){
            sendMessageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }else{
            sendMessageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
        
    }
    
}

extension GroupChatController: UITableViewDataSource, UITableViewDelegate {
    
    func configureTableView(){
        tableView.register(UINib(nibName: "GroupChatHeader", bundle: nil), forCellReuseIdentifier: "GroupChatHeader")
        tableView.register(UINib(nibName: "GroupChatReplyCell", bundle: nil), forCellReuseIdentifier: "GroupChatReplyCell")
    }
    
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 10
        }
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupChatHeader", for: indexPath) as! GroupChatHeader
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupChatReplyCell", for: indexPath) as! GroupChatReplyCell
            return cell
        }
    }
    
   
    
    
}

extension GroupChatController{
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1{
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
    
    
    let replyButton = UITableViewRowAction(style: .normal, title: "Reply") { action, index in
        
        print("Access button tapped")
        
    }
    
    replyButton.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
    
    
        
        return [deleteButton, editButton, replyButton]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
    }
    
}



extension GroupChatController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        
    }
    
    func showError<T>(error: T) {
        
    }
    
}
