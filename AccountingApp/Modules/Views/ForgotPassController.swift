//
//  ForgotPassController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit
import ReusableFramework


class ForgotPassController: UIViewController{
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var cardView: CardView!
    
    var presenter: ViewToPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userEmail.leftMargins()
        
        closeButton.roundCorners(corners: [.topRight, .bottomRight], radius: 10)
        submitButton.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        cardView.transform = CGAffineTransform(translationX: 0, y: 0)
        
        
        UIView.animate(withDuration: 0.6, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            
            self.cardView.transform = .identity
            self.cardView.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    
    @IBAction func handleSubmit(_ sender: Any) {
        
        if userEmail.isEmail(){
            
            if Reachability.isConnectedToNetwork(){
                forgotPassword()
                
            }else{
                self.notInternetView()
            }
            
        }else{
            self.showAlert(message: AlertMessage.email.rawValue)
        }
        
    }
    
    @IBAction func handleClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}



extension ForgotPassController{
    
    func forgotPassword(){
        userEmail.resignFirstResponder()
        
        let forgotPassEntity = ForgotSendEntity(email: userEmail.text)
        submitButton.showActvityIndicator()
        presenter?.updateView(body: forgotPassEntity)
    }
    
    func toNormalState(message: String){
        DispatchQueue.main.async {
            self.submitButton.hideActivityIndicator(title: ForgotPasswordEnum.submit.rawValue)
            self.sheetStyleAlert(message: message)
        }
    }
}

extension ForgotPassController: PresenterToViewProtocol {
    
    func showContent<T>(news: T) {
    
        if let value = news as? String{
            toNormalState(message: value)
        }
    }
    
    func showError<T>(error: T) {
    
        if let errorMessage = error as? String{
            toNormalState(message: errorMessage)
        }

    }


}
