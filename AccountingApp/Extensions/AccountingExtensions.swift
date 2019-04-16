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
    
    func sheetStyleAlert(message: String){
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    var navigationBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
}


extension String{
    
    func getHeader() -> [String: String]{
        guard let token = UserDefaults.standard.value(forKey: KeysEnum.token.rawValue) as? String else{
            let header = [
                "Content-Type":"application/json",
                "client" : "iOS"
            ]
            return header
        }
        
        let (userId, _) = UserHelper.companyID()
        
        let header = [
            "Content-Type":"application/json",
            "token": token,
            "client" : "iOS",
            "userId" : userId
        ]
        return header
    }
    
    func mulitpartHeader() -> [String: String]{
        
        guard let token = UserDefaults.standard.value(forKey: KeysEnum.token.rawValue) as? String else{
            let header = [
                "Content-Type":"application/json",
                "client" : "iOS"
            ]
            return header
        }
          let (userId, _) = UserHelper.companyID()
        return [
            "Content-Type":"multipart/form-data",
            "token": token,
            "client" : "iOS",
            "userId" : userId
        ]
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
            self.pin_setImage(from: imageUrl, placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"))
        }else{
            self.image = #imageLiteral(resourceName: "profilePlaceholder")
        }
    }
}

extension UIButton{
    func addImage(url: String?){
        
        guard let image = url  else {
            self.setImage(#imageLiteral(resourceName: "profilePlaceholder"), for: .normal)
            return
        }
        if let imageUrl = URL(string: GlobalConstants.base + image){
            let profileImageView = UIImageView()
            //profileImageView.pin_setImage(from: imageUrl)
            profileImageView.pin_setImage(from: imageUrl)
            self.setImage(profileImageView.image, for: .normal)
        }else{
            self.setImage(#imageLiteral(resourceName: "profilePlaceholder"), for: .normal)
        }
        
    }
    
}


extension UINavigationController{
    
    func hideTranslucency(){
       //e self.navigationBar.isTranslucent = false
       // self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
       // self.navigationBar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.prefersLargeTitles = true
    }
    
    
    
}


extension UIButton{
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat){
        
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
    }
}


extension UIView{
    
    func roundCorners1(corners: UIRectCorner, radius: CGFloat){
        
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
    }
}
