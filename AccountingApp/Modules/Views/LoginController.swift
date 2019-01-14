//
//  LoginController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

class LoginController: UIViewController{
   
    var presenter: ViewToPresenterProtocol?
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
    
        let forgetPassword = ForgotPassRoute.createModule()
        forgetPassword.modalTransitionStyle = .coverVertical
        forgetPassword.modalPresentationStyle = .overCurrentContext
        self.present(forgetPassword, animated: true, completion: nil)
        
        
    }
    
    @IBAction func loginApp(_ sender: Any) {
    
        if userEmail.isEmpty() || userPassword.isEmpty(){
            showAlert(message: AlertMessage.empty.rawValue)
        }else{
            let loginData = LoginRequestEntity(email: userEmail.text, password: userPassword.text)
            enterButton.showActvityIndicator()
            presenter?.updateView(body: loginData)
        }
        
        
        
    }
    
    
}

extension LoginController: PresenterToViewProtocol {
    
    func showContent<T>(news: T) {
        enterButton.hideActivityIndicator(title: "ENTER")
    }
    
    func showError() {
        enterButton.hideActivityIndicator(title: "ENTER")
    }
    
    
    
}
