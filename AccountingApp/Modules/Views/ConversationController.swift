//
//  ConversationController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 15/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class ConversationController: UIViewController{
    
    @IBOutlet weak var conversationText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "New Conversation"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        conversationText.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
    }
    
    var presenter: ViewToPresenterProtocol?
}

extension ConversationController{
    
    func setup(){
        
        
        let conversationView: ConversationView = UIView.fromNib()
        conversationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(conversationView)
        
        conversationView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        conversationView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        conversationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        conversationView.heightAnchor.constraint(equalToConstant: 49).isActive = true
    }
}

extension ConversationController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        
    }
    
    func showError<T>(error: T) {
        
    }
    
}
