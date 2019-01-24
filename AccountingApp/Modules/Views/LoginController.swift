//
//  LoginController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit
import ReusableFramework
import BiometricAuthentication

class LoginController: UIViewController{
   
    var presenter: ViewToPresenterProtocol?
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfBiometricisOn()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userEmail.leftMargins()
        userPassword.leftMargins()
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
    
        let forgetPassword = ForgotPassRoute.createModule()
        //forgetPassword.modalTransitionStyle = .coverVertical
        forgetPassword.modalPresentationStyle = .overCurrentContext
        self.present(forgetPassword, animated: false, completion: nil)
        
        
    }
    
    @IBAction func loginApp(_ sender: Any) {
    
        if userEmail.isEmpty() || userPassword.isEmpty(){
            showAlert(message: AlertMessage.empty.rawValue)
        }else{
            
            if Reachability.isConnectedToNetwork(){
                userLogin()
            }else{
                self.notInternetView()
            }
        }
    }
    
}

extension LoginController{
    
    func checkIfBiometricisOn(){
        
        if CredentialsCheck.isSecured(){
            BioMetricAuthenticator.authenticateWithBioMetrics(reason: BioMetricConstants.reasonForSecurity.rawValue, success: {
                // authentication successful
                DispatchQueue.main.async {
                    self.goToMainScreen()
                }
            }, failure: { [weak self] (error) in
                // do nothing on canceled
                self?.sheetStyleAlert(message: error.message())
            })
        }
        
    }
    
    func goToMainScreen(){
        
        //let homeController = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "HomeController")
        ChangeRootViewController.changeRootViewController(to: ChangeToControllerEnum.HomeController)
        
    }
    
    
}


extension LoginController{
    
    func userLogin(){
        
        self.view.endEditing(true)
        self.view.isUserInteractionEnabled =  false
        
        userEmail.resignFirstResponder()
        userPassword.resignFirstResponder()
    
        let loginData = LoginRequestEntity(email: userEmail.text, password: userPassword.text)
        enterButton.showActvityIndicator()
        presenter?.updateView(body: loginData)
        
    }
    
    func loginFailed(message: String){
        self.view.isUserInteractionEnabled =  true
        enterButton.hideActivityIndicator(title: LoginEnum.enter.rawValue)
        self.sheetStyleAlert(message: message)
    }
    
    func loginSuccess(){
        self.view.isUserInteractionEnabled =  true
        enterButton.hideActivityIndicator(title: LoginEnum.enter.rawValue)
        
       // let homeController = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "HomeController")
        
        ChangeRootViewController.changeRootViewController(to: ChangeToControllerEnum.HomeController)
        
    }
}

extension LoginController: PresenterToViewProtocol {
    
    func showContent<T>(news: T) {
            self.loginSuccess()
    }
    
    func showError<T>(error: T) {
    
            if let errorMessage = error as? String{
                self.loginFailed(message: errorMessage)
            }
    }
    
}
