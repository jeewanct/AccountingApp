//
//  AccountingExtensions.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit
import PINRemoteImage



extension UITextField{
    
    func isEmpty() -> Bool{
        if self.text == ""{
            return true
        }
        
        return false
        
    }
    
    func isEmail() -> Bool{
        
        guard let text = self.text else {
            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
        
    }
    
    
}


extension UIViewController{
    
    func showAlert(message: String){
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}


extension String{
    
    func getHeader() -> [String: String]{
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else{
            let header = [
                "Content-Type":"application/json",
                "client" : "android"
            ]
            return header
        }
        
        let header = [
            "Content-Type":"application/json",
            "token": token,
            "client" : "android"
        ]
        
        
        return header
    }
}


extension UIButton{
    

    func showActvityIndicator(){
        let ai = UIActivityIndicatorView()
        ai.style = .white
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.tag = 0
        self.addSubview(ai)
        ai.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        ai.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        ai.startAnimating()
        self.setTitle("", for: .normal)
        
    }
    
    func hideActivityIndicator(title: String){
        
        for view in subviews{
            if view is UIActivityIndicatorView{
                guard let ai = view as? UIActivityIndicatorView else {
                    return
                }
                ai.stopAnimating()
                ai.removeFromSuperview()
                self.setTitle(title, for: .normal)
            }
        }
        
        
        
    }
    
}


extension UIImageView{
    func addImage(url: String?){
        
        guard let image = url  else {
            self.image = #imageLiteral(resourceName: "profilePlaceholder")
            return
        }
        if let imageUrl = URL(string: GlobalConstants.base + image){
            self.pin_setImage(from: imageUrl)
        }
        
    }
}


extension UINavigationController{
    
    func hideTranslucency(){
        self.navigationBar.isTranslucent = false
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
    }
    
}
