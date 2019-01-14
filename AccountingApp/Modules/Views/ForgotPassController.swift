//
//  ForgotPassController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

class ForgotPassController: UIViewController{
    
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    var presenter: ViewToPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleSubmit(_ sender: Any) {
        
        if userEmail.isEmail(){
            let forgotPassEntity = ForgotSendEntity(email: userEmail.text)
            submitButton.showActvityIndicator()
            presenter?.updateView(body: forgotPassEntity)
        }else{
            self.showAlert(message: AlertMessage.email.rawValue)
        }
        
    }
    
    @IBAction func handleClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension ForgotPassController: PresenterToViewProtocol {
    
    func showContent<T>(news: T) {
        submitButton.hideActivityIndicator(title: "SUBMIT")
    }
    
    func showError() {
        submitButton.hideActivityIndicator(title: "SUBMIT")
//        showAlert(message: NetworkError.noInternet.rawValue)
    }

}
